extern crate regex;

fn get_re(string: &str) -> (regex::Regex, usize) {

	let re_custom = regex::Regex::new(r"//(.)\n").unwrap();
	let re_multi_custom = regex::Regex::new(r"//(.*)\n").unwrap();
	let re_unwrap = regex::Regex::new(r"\[(.*?)\]").unwrap();

	if re_custom.is_match(string)  {

		let delimiter = re_custom.captures(string)
							.unwrap()
							.at(1)
							.unwrap();
		let re = regex::Regex::new(delimiter).unwrap();

		return (re, 4);
	} else {
		if re_multi_custom.is_match(string) {
			
			let mut delimiter_list: Vec<&str> = vec![];

			let delimiters = re_multi_custom.captures(string)
								.unwrap()
								.at(1)
								.unwrap();

			for cap in re_unwrap.captures_iter(delimiters) {
				delimiter_list.push(cap.at(1).unwrap());
			} 
					
			let re = regex::Regex::new(&delimiter_list.connect("|")).unwrap();

			let start_position = re_multi_custom.captures(string)
								.unwrap()
								.at(0)
								.unwrap()
								.len();

			return (re, start_position);

		} else {

				let re = regex::Regex::new(",|\n").unwrap();

				return (re , 0);

			}
		}
	}
	

pub fn add(string: &str) -> i32 {


	let (re, start_position) = get_re(string);

	let mut list_negatives: Vec<i32> = vec![];

	let mut sum: i32 = 0;
	if string != "" {
		for s in re.split(&string[start_position..]) {
 			let x: i32 = s.trim().parse().unwrap();
 			if x < 0 {
 				list_negatives.push(x);
 			} else {
 				if x < 1001 {
					sum += x;
 				}
 			}
		}
	}
	if list_negatives.len() !=0 {
		panic!("negatives not allowed {:?}", list_negatives);
	}

	return sum;
}


#[cfg(test)]
mod tests {

	use super::add;
	
	#[test]
	fn should_return_zero_when_given_empty_string() {
		assert_eq!(0, add(""));
	}
	#[test]
	fn should_return_number_when_given_one_number() {
		assert_eq!(23, add("23"));
	}
	#[test]
	fn should_return_sum_when_given_multiple_numbers() {
		assert_eq!(6, add("1,2,3"));
	}
	#[test]
	fn should_return_sum_when_given_multiple_numbers_comma_and_nl() {
		assert_eq!(6, add("1,2,3"));
	}
	#[test]
	#[should_panic]
	fn should_panic_and_list_them_when_given_negatives() {
		assert_eq!(-3, add("1,-2,3,-4,5,-6"));
	}
	#[test]
	fn should_return_ignore_numbers_gt_1000() {
		assert_eq!(1003, add("1001,1000,3"));
	}
	#[test]
	fn should_return_sum_when_given_custom_delim() {
		assert_eq!(6, add("//;\n1;2;3"));
	}
	#[test]
	fn should_return_sum_when_given_multi_char_custom_delim() {
		assert_eq!(6, add("//[abc]\n1abc2abc3"));
	}
	#[test]
	fn should_return_sum_when_given_n_multi_char_custom_delim() {
		assert_eq!(6, add("//[abc][de]\n1abc2de3"));
	}

}

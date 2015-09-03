extern crate regex;

fn get_delimiter(string_numbers:&str) -> (regex::Regex, usize) {

	let re = regex::Regex::new(r"//(.)\n").unwrap();
	let re_multi = regex::Regex::new(r"//(.*)\n").unwrap();
	let re_multi_split = regex::Regex::new(r"\[(.*?)\]").unwrap();

	if re.is_match(&string_numbers) {

		let delimiter = re.captures(&string_numbers)
							.unwrap()
							.at(1)
							.unwrap();
		let re = regex::Regex::new(&delimiter).unwrap();
		
		return (re, 4);
	} else {
		if re_multi.is_match(string_numbers) {
			let mut list_delim: Vec<&str> = vec![];					

			let delimiter_string = re_multi.captures(&string_numbers)
								.unwrap()
								.at(1)
								.unwrap();

			for cap in re_multi_split.captures_iter(&delimiter_string) {
				list_delim.push(cap.at(1).unwrap());
			}

			let re = regex::Regex::new(&list_delim.connect("|")).unwrap();

			let start_position = re_multi.captures(&string_numbers)
								.unwrap()
								.at(0)
								.unwrap()
								.len();
			return (re, start_position);

		} else	{
			let re = regex::Regex::new(",|\n").unwrap();
			return (re, 0);
		}
	}
}

pub fn add_string(string_numbers:&str) -> i32 {
			
	let mut sum = 0;
	let (re, start_position) = get_delimiter(&string_numbers);
	let mut list_negatives: Vec<i32> = vec![];

	let mut x: i32;

	for s in re.split(&string_numbers[start_position..]) {
		x = s.trim().parse().unwrap();
		if x < 0 {
			list_negatives.push(x);
		}
		if x < 1001 {
			sum += x;
		}
	}

	if list_negatives.len() != 0 {
		panic!("negatives not allowed {:?}", list_negatives);
	}

	return sum;

}


#[cfg(test)]
mod tests {
	use super::add_string;

	#[test]
	fn should_return_zero_when_given_empty_string() {
		assert_eq!(0, add_string(""));
	}
	#[test]
	fn should_return_number_when_given_one_number() {
		assert_eq!(0, add_string("0"));
		assert_eq!(5, add_string("5"));
		assert_eq!(23, add_string("23"));
	}
	#[test]
	fn should_return_sum_when_given_two_numbers_comma_delim() {
		assert_eq!(3, add_string("1,2"));
	}
	#[test]
	fn should_return_sum_when_given_n_numbers_comma_delim() {
		assert_eq!(21, add_string("1,2,3,4,5,6"));
	}
	#[test]
	fn should_return_sum_when_given_n_numbers_comma_or_nl_delim() {
		assert_eq!(21, add_string("1,2,3\n4,5,6"));
	}
	#[test]
	fn should_return_sum_when_given_custom_demlim() {
		assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
	}
	#[test]
	#[should_panic]
	fn should_panic_when_given_negatives() {
		assert_eq!(-3, add_string("1,-2,3,-4,5,-6"));
	}
	#[test]
	fn should_ignore_when_gt_1000() {
		assert_eq!(1001, add_string("1,1000,1001"));
	}
	#[test]
	fn should_support_multi_char_delim() {
		assert_eq!(6, add_string("//[abc]\n1abc2abc3"));
	}
	#[test]
	fn should_support_n_multi_char_delim() {
		assert_eq!(6, add_string("//[abc][de]\n1abc2de3"));
	}

}

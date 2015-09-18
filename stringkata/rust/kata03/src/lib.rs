extern crate regex;

fn get_delim(string: &str) -> (regex::Regex, usize) {
	let re_custom = regex::Regex::new("//(.)\n").unwrap();

	if re_custom.is_match(string) {
		let delim: &str = re_custom.captures(string)
							.unwrap()
							.at(1)
							.unwrap();
		let re = regex::Regex::new(delim).unwrap();
		return (re, 4);
	} else {
		let re = regex::Regex::new(",|\n").unwrap();
		return (re, 0);
	}

}

pub fn add(string: &str) -> i32 {
	let mut sum: i32 = 0;
	let (re, start_position) = get_delim(string);

	if string == "" {
		return sum;
	} else {
		for s in re.split(&string[start_position..]) {
			let x: i32 = s.trim().parse().unwrap();
			sum += x;
		}
		return sum;
	}
}


#[cfg(test)]
mod tests {
	use super::add;

	#[test]
	fn when_given_empty_string_it_should_return_zero() {
		assert_eq!(0, add(""));
	}
	#[test]
	fn when_given_number_it_should_return_its_value() {
		assert_eq!(23, add("23"));
	}
	#[test]
	fn when_given_two_numbers_comma_delim_it_should_return_their_sum() {
		assert_eq!(3, add("1,2"));
	}
	#[test]
	fn when_given_n_numbers_comma_delim_it_should_return_their_sum() {
		assert_eq!(21, add("1,2,3,4,5,6"));
	}
	#[test]
	fn when_given_n_numbers_comma_or_nl_delim_it_should_return_their_sum() {
		assert_eq!(21, add("1,2,3\n4,5,6"));
	}
	#[test]
	fn when_given_n_numbers_custom_delim_it_should_return_their_sum() {
		assert_eq!(21, add("//;\n1;2;3;4;5;6"));
	}
	#[test]
	#[should_panic]
	fn when_given_negative_numbers_it_should_panic() {
		assert_eq!(-3, add("1,-2,3,-4,5,-6"));
	}
}

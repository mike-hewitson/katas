extern crate regex;

pub fn get_delimiter(string_numbers: &str) -> (&str,usize) {
	let delimiter: &str;
	let mut string_start: usize = 0;
	let re = regex::Regex::new(r"//(.)\n").unwrap();
	if re.is_match(string_numbers) {
		delimiter =
			match re.captures(string_numbers).unwrap().at(1) {
				Some(s) => s,
				None 	=> ""
			};
		string_start = 4;
	} else {
		delimiter = ",|\n";
		string_start = 0;
	}
	return (delimiter, string_start);
}


pub fn add_string(string_numbers: &str) -> i32 {
	let mut sum: i32 = 0;
	let delimiter: &str;
	let string_start: usize;
	
	if string_numbers == "" {
		sum = 0;
	} else {
		let (delimiter, string_start) = get_delimiter(string_numbers);
		let re = regex::Regex::new(delimiter).unwrap();
		for s in re.split(&string_numbers[string_start..]) {
			let x: i32 = s.trim().parse()
					.ok()
					.expect("Not a numeric");
			sum += x;
		}
	}
	return sum;
}

#[cfg(test)]
mod tests {
	use super::add_string;

	#[test]
	fn should_return_zero_for_empty_string() {
		assert_eq!(0, add_string(""));

	}
	#[test]
	fn should_return_number_given_a_single_number() {
		assert_eq!(0, add_string("0"));
		assert_eq!(5, add_string("5"));
		assert_eq!(23, add_string("23"));
	}
	#[test]
	fn should_return_sum_given_two_numbers_comma_delim() {
		assert_eq!(3, add_string("1,2"));
		assert_eq!(23, add_string("10, 13"));
	}
	#[test]
	fn should_return_sum_given_n_numbers_comma_delim() {
		assert_eq!(21, add_string("1,2,3,4,5,6"));
	}
	#[test]
	fn should_return_sum_given_n_numbers_comma_or_nl_delim() {
		assert_eq!(21, add_string("1,2,3\n4,5,6"));
	}
	#[test]
	fn should_return_sum_given_n_numbers_custom_demiliter() {
		assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
	}
}

extern crate regex;


pub fn establish_delimiter(string_numbers: &str) -> &str {
	let re_custom = regex::Regex::new(r"//(.)\n");
	let delimiter: &str;
	
}


pub fn add_string(string_numbers: &str) -> i32 {
	let mut sum: i32 = 0;

	let re = regex::Regex::new(",|\n").unwrap();

	if string_numbers == "" {
		sum = 0;
	} else {
		for s in re.split(string_numbers) {
			let x: i32 = s.trim().parse()
				.ok()
				.expect("Not a number");
			sum += x;
		}
	}
	return sum;
}

#[cfg(test)]
mod tests {

	use super::add_string;

	#[test]
	fn return_zero_when_given_empty_string() {
		assert_eq!(0, add_string(""));
	}
	#[test]
	fn return_number_when_given_one_number() {
		assert_eq!(0, add_string("0"));
		assert_eq!(6, add_string("6"));
		assert_eq!(23, add_string("23"));
	}
	#[test]
	fn return_sum_when_given_two_numbers_comma_seperated() {
		assert_eq!(3, add_string("1,2"));
		assert_eq!(23, add_string("10,13"));
	}
	#[test]
	fn return_sum_when_given_any_numbers_comma_seperated() {
		assert_eq!(21, add_string("1,2,3,4,5,6"));
	}
	#[test]
	fn return_sum_when_given_any_numbers_comma_or_nl_seperated() {
		assert_eq!(21, add_string("1,2,3,4\n5,6"));
	}
	
}

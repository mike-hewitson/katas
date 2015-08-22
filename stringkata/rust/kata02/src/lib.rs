extern crate regex;

pub fn add(number_string: &str) -> i32 {
	let re = regex::Regex::new(r",|\n").unwrap();
	let mut sum: i32 = 0;
	if number_string != "" {
		let string_list = re.split(number_string);
		for s in string_list {
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
	use super::add;

	#[test]
	fn returns_zero_given_empty_string() {
		assert_eq!(0, add(""));
	}
	#[test]
	fn returns_number_given_one_number() {
		assert_eq!(0, add("0"));
		assert_eq!(1, add("1"));
		assert_eq!(23, add("23"));
	}	
	#[test]
	fn returns_sum_given_two_numbers_seperated_by_comma() {
		assert_eq!(3, add("1,2"));
		assert_eq!(23, add("10,13"));
	}
	#[test]
	fn returns_sum_given_many_numbers_seperated_by_comma() {
		assert_eq!(21, add("1,2,3,4,5,6"));
	}
	#[test]
	fn returns_sum_given_many_numbers_seperated_by_comma_or_nl() {
		assert_eq!(21, add("1,2,3,4\n5,6"));
	}
}
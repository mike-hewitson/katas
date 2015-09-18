extern crate regex;


pub fn add(string: &str) -> i32 {
	let mut sum: i32 = 0;
	let re = regex::Regex::new(",|\n").unwrap();

	if string == "" {
		return sum;
	} else {
		for s in re.split(string) {
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
}

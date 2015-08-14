pub fn add_numbers(num_string: &str) -> i32 {
	let mut sum: i32 = 0;
	let list_strings = num_string.split(",");
	for s in list_strings {
		println!("{}", s);
		if s != "" {
			sum = sum + s.trim().parse()
					.ok() 
					.expect("Not a number");		
		}
	}
	return sum;
}

#[cfg(test)]
mod tests {
	use super::add_numbers;

	#[test]
	fn return_zero_on_empty_string() {
		assert_eq!(0, add_numbers(""));
	}
	#[test]
	fn return_single_number() {
		assert_eq!(0, add_numbers("0"));
		assert_eq!(1, add_numbers("1"));
		assert_eq!(23, add_numbers("23"));
	}
	#[test]
	fn return_the_sum_of_two_numbers_seperated_by_commas() {
		assert_eq!(3, add_numbers("1,2"));
		assert_eq!(23, add_numbers("10,13"));
	}
}
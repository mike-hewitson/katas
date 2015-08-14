extern crate regex;


pub fn add_string(number_string: &str) -> i32 {
	let mut sum: i32 = 0;
	let re = regex::Regex::new(r",|\n").unwrap();
	let re2 = regex::Regex::new(r"//(\[.*?\])\n").unwrap();
	let test = re2.captures(number_string).unwrap();
	println!("Here i am :{:?}", test.at(0));
	println!("Here i am :{:?}", test.at(1));
	println!("Here i am :{:?}", test.at(2));
	let list_nums = re.split(number_string);
	for s in list_nums {
		if s != "" {
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
	fn it_should_return_zero_given_empty_string() {
		assert_eq!(0, add_string(""));
	}	
	#[test]
	fn it_should_return_number_given_a_number() {
		assert_eq!(1, add_string("1"));
		assert_eq!(5, add_string("5"));
		assert_eq!(23, add_string("23"));
	}
	#[test]
	fn it_should_return_the_sum_given_two_numbers_comma_del() {
		assert_eq!(4, add_string("1,3"));
		assert_eq!(23, add_string("10, 13"));
	}	
	#[test]
	fn it_should_return_the_sum_given_n_numbers_comma_del() {
		assert_eq!(21, add_string("1,2,3,4,5,6"));
	}	
	#[test]
	fn it_should_also_support_nl() {
		assert_eq!(21, add_string("1,2\n3,4,5,6"));
	}	
	#[test]
	fn it_should_support_custom_delimiter() {
		assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
	}	
}

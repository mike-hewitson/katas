extern crate regex;

fn get_delimiters(string_numbers:&str) -> (regex::Regex, usize) {

    let re_custom_short = regex::Regex::new(r"//(.)\n").unwrap();

    if re_custom_short.is_match(string_numbers) {
        
        let delimiter = re_custom_short.captures(string_numbers)
                            .unwrap()
                            .at(1)
                            .unwrap();
        let re = regex::Regex::new(&delimiter).unwrap();    
 
        return (re, 4);
    } else {

        let re = regex::Regex::new(&",|\n").unwrap();    

        return (re, 0);
    }

}

pub fn add_string(string_numbers:&str) -> i32 {


    let mut sum = 0;
    let (re, start_position) = get_delimiters(&string_numbers);

    if string_numbers != "" {
        let mut x: i32;
        for s in re.split(&string_numbers[start_position..]) {
            x = s.trim().parse().unwrap();
            sum += x;
            
        }
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
        assert_eq!(23, add_string("10,13"));
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
    fn should_return_sum_when_given_custom_delim() {
        assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
    }
}


extern crate regex;

pub fn find_delimiter(string_number: &str) -> &str {

    let re_custom = regex::Regex::new(r"//(.)\n").unwrap();
    let delimiter: &str;

    if re_custom.is_match(string_number) {
            delimiter = 
                match re_custom.captures(string_number).unwrap().at(1) {
                    Some(x) => x,
                    None    => ""
                };
    } else {
        delimiter = ",|\n";
    }

    return delimiter;  
}

pub fn add_string(string_number: &str) -> i32 {
    
    let mut sum: i32 = 0;
    let delimiter: &str;
    let trim_string: &str;

    if string_number != "" {
        delimiter = find_delimiter(string_number);
 
        if delimiter != ",|\n" {
            trim_string = &string_number[4..];
        } else {
            trim_string = &string_number;
        }

        let re = regex::Regex::new(delimiter).unwrap();

        let list_strings = re.split(trim_string);
        for s in list_strings {
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
    fn should_return_zero_when_given_empty_string() {
        assert_eq!(0, add_string(""));
    }
    #[test]
    fn should_return_number_when_given_single_number() {
        assert_eq!(0, add_string("0"));
        assert_eq!(5, add_string("5"));
        assert_eq!(23, add_string("23"));
    }
    #[test]
    fn should_return_sum_when_given_two_number_with_comma_delim() {
        assert_eq!(3, add_string("1,2"));
        assert_eq!(23, add_string("10,13"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_with_comma_delim() {
        assert_eq!(21, add_string("1,2,3,4,5,6"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_with_comma_or_nl_delim() {
        assert_eq!(21, add_string("1,2,3\n4,5,6"));
    }
        #[test]
    fn should_return_sum_when_given_any_numbers_with_custom_delim() {
        assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
    }

}
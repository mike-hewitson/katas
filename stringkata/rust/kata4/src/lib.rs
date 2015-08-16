
extern crate regex;
use regex::Regex;

pub fn add_string(string_number: &str) -> i32 {
    let mut sum: i32 = 0;
    let re2 = regex::Regex::new(r"//(.)\n").unwrap();
    println!("{:?}", re2.is_match(string_number) );
    if re2.is_match(string_number) {
        let delimiter = {
            match re2.captures(string_number).unwrap().at(0) {
                Some(x) => x,
                None    => ",|\n"
            }
        };
        
        // let split_regex = re2;
    } else {
        let re2 = regex::Regex::new(r",|\n").unwrap();
    }
    // let re = regex::Regex::new(r"//(.)\n").unwrap();
    // println!("{:?}", re.is_match(string_number) );

    // let try_delimiter = re2.captures(string_number);
    // // let try_delimiter = re2.captures(string_number).unwrap();
    
    // println!("Here i am :{:?}", try_delimiter.unwrap());
    // let re = Regex::new(delimiter).unwrap();   
    // println!("Here i am :{:?}", try_delimiter.at(0));
    // println!("Here i am :{:?}", try_delimiter.at(1));
    // println!("Here i am :{:?}", try_delimiter.at(2));

    // let re = Regex::new(test.at(0)).unwrap();
    if string_number != "" {
        let list_strings = re2.split(string_number);
        for s in list_strings {
            let x: i32 = s.trim().parse()
                            .ok()
                            .expect("Must be a numeric");
            sum += x;
        }
    }
    return  sum;
}

#[cfg(test)]
mod test {
    use super::add_string;

    #[test]
    fn should_return_zero_for_empty_string() {
        assert_eq!(0, add_string(""));
    }
    #[test]
    fn should_return_the_number_for_a_single_number() {
        assert_eq!(0, add_string("0"));
        assert_eq!(5, add_string("5"));
        assert_eq!(23, add_string("23"));
    }
    #[test]
    fn should_return_the_sum_of_two_numbers_comma_delim() {
        assert_eq!(3, add_string("1,2"));
        assert_eq!(23, add_string("10,13"));
    }
    #[test]
    fn should_return_the_sum_of_n_numbers_comma_delim() {
        assert_eq!(21, add_string("1,2,3,4,5,6"));
    }
    #[test]
    fn should_return_the_sum_of_n_numbers_comma_delim_or_nl() {
        assert_eq!(21, add_string("1,2,3\n4,5,6"));
    } 
   #[test]
    fn should_return_the_sum_of_n_numbers_custom_delimter() {
        assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
    }
}
extern crate regex;

fn get_delimiter(string_numbers: &str) -> (regex::Regex, usize) {

    let re_custom_single = regex::Regex::new(r"//(.)\n").unwrap();
    let re_custom_multi = regex::Regex::new(r"//\[(.*)\]\n").unwrap();

    if re_custom_single.is_match(string_numbers) {

        let delimiter = re_custom_single
                            .captures(string_numbers)
                            .unwrap()
                            .at(1)
                            .unwrap();
        let re = regex::Regex::new(delimiter)
                    .unwrap();

        return (re, 4);

    } else {
        if re_custom_multi.is_match(string_numbers) {
  
           let delimiter = re_custom_multi
                            .captures(string_numbers)
                            .unwrap()
                            .at(1)
                            .unwrap();
            let re = regex::Regex::new(delimiter)
                        .unwrap();
            let start_pos = re_custom_multi.captures(string_numbers)
                                .unwrap()
                                .at(0)
                                .unwrap()
                                .len();
            return (re, start_pos);

        } else {
            
            return (regex::Regex::new(r",|\n").unwrap() , 0);            
        }
    }

}


pub fn add_string(string_numbers: &str) -> i32 {

    let mut sum = 0;
    let mut list_negatives: Vec<i32> = vec![];

    let (re, start_pos) = get_delimiter(string_numbers);

    if string_numbers == "" {
        sum = 0;
    } else {

        for s in re.split(&string_numbers[start_pos..]) {
            
            let x: i32 = s.trim().parse().unwrap();

            if x < 0 {
                list_negatives.push(x);
            } else {
                if x < 1001 {
                    sum += x;               
                }
            }
        }
    }    

    if list_negatives.len() == 0 {
        return sum;
    } else {
        panic!("negatives not allowed {:?}", list_negatives);
    }

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
    fn should_return_number_when_given_two_numbers_comma_del() {   
        assert_eq!(3, add_string("1,2"));  
        assert_eq!(23, add_string("10,13"));  
    }
    #[test]
    fn should_return_number_when_given_n_numbers_comma_del() {   
        assert_eq!(21, add_string("1,2,3,4,5,6"));  
    }
    #[test]
    fn should_return_number_when_given_n_numbers_comma_or_nl_del() {   
        assert_eq!(21, add_string("1,2,3\n4,5,6"));  
    }
    #[test]
    fn should_return_number_when_given_custom_del() {   
        assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));  
    }
    #[test]
    fn should_return_number_when_given_custom_del_colon() {   
        assert_eq!(21, add_string("//:\n1:2:3:4:5:6"));  
    }
    #[test]
    #[should_panic]
    fn should_panic_when_given_negatives() {   
        assert_eq!(-3, add_string("1,-2,3,-4,5,-6"));  
    }
    #[test]
    fn should_return_number_when_given_n_numbers_ignoring_gt_1000() {   
        assert_eq!(1001, add_string("1,1000,1001"));  
    }
    #[test]
    fn should_return_number_when_given_n_numbers_custom_multi_char_del() {   
        assert_eq!(6, add_string("//[aaa]\n1aaa2aaa3"));  
        assert_eq!(6, add_string("//[abc]\n1abc2abc3"));  
    }
}
extern crate regex;

pub fn get_delimiters(string_numbers: &str) -> (regex::Regex, usize) {

    let re_custom_one_char = regex::Regex::new(r"//(.)\n").unwrap();
    let re_custom_n_char = regex::Regex::new(r"//\[(.*?)\]\n").unwrap();

    if re_custom_one_char.is_match(string_numbers) {
        return (regex::Regex::new(re_custom_one_char.captures(string_numbers).unwrap().at(1).unwrap()).unwrap(), 
            re_custom_one_char.captures(string_numbers).unwrap().at(0).unwrap().len());
    } else {
        if re_custom_n_char.is_match(string_numbers) {
             return (regex::Regex::new(re_custom_n_char.captures(string_numbers).unwrap().at(1).unwrap()).unwrap(), 
                re_custom_n_char.captures(string_numbers).unwrap().at(0).unwrap().len());
                
        } else {
            return (regex::Regex::new(",|\n").unwrap(), 0);
        }
    }
}

pub fn add_string(string_numbers: &str) -> i32 {
    let mut sum: i32 = 0;
    let mut list_negatives: Vec<i32> = vec![];


    if string_numbers == "" {
        sum = 0;
    } else {

        let (re, string_start) = get_delimiters(string_numbers);

        for s in re.split(&string_numbers[string_start..]) {

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
    if list_negatives.len() != 0 {
        println!("Newgatives found{:?}", list_negatives);
        panic!("Negatives found");
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
    fn should_return_sum_when_given_two_numbers_comma_delim() {
        assert_eq!(3, add_string("1,2"));
        assert_eq!(23, add_string("10,13"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_comma_delim() {
        assert_eq!(21, add_string("1,2,3,4,5,6"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_comma_or_nl_delim() {
        assert_eq!(21, add_string("1,2,3,4\n5,6"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_custom_delim() {
        assert_eq!(21, add_string("//;\n1;2;3;4;5;6"));
    }
    #[test]
    #[should_panic]
    fn should_panic_sum_when_given_any_negative_numbers_custom_delim() {
        assert_eq!(21, add_string("1,-2,3,-4,5,-6"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_ignoring_gt_1000() {
        assert_eq!(1015, add_string("1,1000,3,1001,5,6"));
    }
    #[test]
    fn should_return_sum_when_given_any_numbers_custom_delim_any_length() {
        assert_eq!(21, add_string("//[aaa]\n1aaa2aaa3aaa4aaa5aaa6"));
    }
}
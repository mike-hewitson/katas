pub fn add_string(a: &str) -> i32 {
    let mut sum: i32 = 0;
    let split = a.split(",");
    for s in split {

        println!("{}", s);
        sum += s.trim().parse()
            .ok()
            .expect("Not a number"); 
    }
    // if a != "" {
    //     sum = a.trim().parse()
    //         .ok()
    //         .expect("Not a number"); 
    // }        
    return sum;
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn empty_string_returns_zero() {
        assert_eq!(0, add_string(""));
    }
    #[test]
    fn single_digit_returns_the_digit() {
        assert_eq!(1, add_string("1"));
        assert_eq!(3, add_string("3"));
    }
    #[test]
    fn single_number_returns_the_number() {
        assert_eq!(10, add_string("10"));
        assert_eq!(23, add_string("23"));
    }
    #[test]
    fn sum_two_numbers() {
        assert_eq!(3, add_string("1,2"));
        assert_eq!(23, add_string("20,3"));
    }
}
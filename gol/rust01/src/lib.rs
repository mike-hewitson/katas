extern crate num;
use num::abs;


pub struct Point {
	x: i32,
	y: i32,
	current_state: bool,
	future_state: bool,
	live_neighbours: i32,
}

impl Default for Point {
    fn default() -> Point {
        Point {
			x: 0,
			y: 0,
			current_state: true,
			future_state: false,
			live_neighbours: 0,
        }
    }
}

pub fn count_neighbours(&p: Point, &world: Vec<Point>) -> i32 {
	for point in world {
		if is_neighbour(p, point) {
			point.live_neighbours += 1;
		}
	}
}

pub fn is_neighbour(p1: &Point, p2: &Point) -> bool {
	if p1.x == p2.x && p1.y == p2.y {
		false
	} else {
		if abs(p1.x - p1.y) < 2 && abs(p1.y - p2.y) < 2 {
			true
		} else {
			false
		}
	}
}

pub fn main() {

	let bob: Point = Point {x:0, y: 0, ..Default::default()};

	let mut world: Vec<Point> = vec![];
	// let mut candidates: Vec<Point> = vec![];
	world.push(bob);
}

#[test]
fn are_cells_neighbours() {
	let p1: Point = Point {x:0, y: 0, ..Default::default()};
	let p2: Point = Point {x:0, y: 1, ..Default::default()};
	let p3: Point = Point {x:1, y: 2, ..Default::default()};
	let p4: Point = Point {x:0, y: 2, ..Default::default()};
	let p5: Point = Point {x:0, y: 3, ..Default::default()};
	assert_eq!(true, is_neighbour(&p1, &p2));
	assert_eq!(false, is_neighbour(&p1, &p3));
	assert_eq!(true, is_neighbour(&p2, &p3));
	assert_eq!(false, is_neighbour(&p1, &p4));
	assert_eq!(false, is_neighbour(&p1, &p5));
}

#[test]
fn cell_cant_be_its_own_neighbour() {
	let p1: Point = Point {x:0, y: 0, ..Default::default()};
	assert_eq!(false, is_neighbour(&p1, &p1));
}

#[test]
fn should_return_number_of_live_adjacent_cells_when_0() {
	let bob: Point = Point {x:0, y: 0, ..Default::default()};
	let mut world: Vec<Point> = vec![]; 
	world.push(Point {x:0, y: 0, ..Default::default()});
	assert_eq!(0, count_neighbours(&bob, &world))
}


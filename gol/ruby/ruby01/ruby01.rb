class Point 
	attr_reader :x, :y, :neighbours
	def initialize(x,y)
		@x = x
		@y = y
		@neighbours = 0
	end

	def set_neighbours(neighbours)
		@neighbours = neighbours
	end

end

class World
	attr_reader :points
	def initialize(point)
		@points = []
		@points.push(point)
	end
	def add_point(point)
		@points.push(point)
	end
	def get_neighbours(index)
		points.each do |point|
			neighbours = 0
			if points[index].x != point.x or points[index].y != point.y do
				if 
		end

end

world = [Point.new(1,2), Point.new(2,3)]




describe "Point" do
	describe ".initialize" do
		it "should return x,y " do
			point = Point.new(1,2)
			expect(point.x).to eq 1
			expect(point.y).to eq 2
		end
	end
	describe ".set_neighbours" do
		point = Point.new(1,2)
		it "should save number of neighbours" do
			expect(point.set_neighbours(4)).to eq 4
		end
		it "should retreive stored neighbours" do
			expect(point.neighbours).to eq 4
		end
	end
end

describe "World" do
	describe ".initialize" do
		it "should initialise with a point" do
			world = World.new(Point.new(1,2))
			expect(world.points[0].x).to eq 1
			expect(world.points[0].y).to eq 2
		end
	end
	describe ".add_point" do
		it "should add a second point" do
			world = World.new(Point.new(1,2))
			world.add_point(Point.new(3,4))
			expect(world.points[1].x).to eq 3
			expect(world.points[1].y).to eq 4
		end
	end	
	describe ".get_neigbours" do
		it "should return the correct number of neighbours when there is one" do
			world = World.new(Point.new(1,2))
			world.add_point(Point.new(1,1))
			world.get_neigbours(0)
			expect(world.points[0].neighbours).to eq 1
		end
	end
end
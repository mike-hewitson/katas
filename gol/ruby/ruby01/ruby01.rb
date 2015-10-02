class Point 
	attr_reader :x, :y, :neighbours, :future_state
	def initialize(x,y)
		@x = x
		@y = y
		@neighbours = 0
		@future_state = :dead
	end

	def set_neighbours(neighbours)
		@neighbours = neighbours
	end

	def set_future_state(future_state)
		@future_state = future_state
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
			if points[index].x != point.x or points[index].y != point.y 
				puts "in here"
				if (points[index].x - point.x).abs < 2 and (points[index].y - point.y).abs < 2
					neighbours += 1
				end
				points[index].set_neighbours(neighbours)
			end 
		end
	end

	# def calc_future_state(index)
	# 	case points[index].neighbours
	# 	when neighbours < 2
	# 		points[index].set_future_state :alive
			
	# 	end
	# end

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
	describe ".set_future_state" do
		it "should return a future state of :dead when new point" do
			point = Point.new(1,2)
			expect(point.future_state).to eq :dead
		end
		it "should return a future state of :alive when set" do
			point = Point.new(1,2)
			point.set_future_state(:alive)			
			expect(point.future_state).to eq :alive
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
	describe ".get_neighbours" do
		it "should return the correct number of neighbours when there is one" do
			world = World.new(Point.new(1,2))
			world.add_point(Point.new(1,1))
			world.get_neighbours(0)
			expect(world.points[0].neighbours).to eq 1
		end
	end
end
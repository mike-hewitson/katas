class Point 
	attr_reader :x, :y, :current_state, :neighbours
	def initialize(x,y)
		@x = x
		@y = y
		@current_state = :alive
		@neighbours = 0
	end
end

class World
	attr_reader :points
	def initialize
		@points = []
	end

	def add_point(point)
		@points.push(point)
	end

	def find_neighbours(this_point)
		neighbours = 0
		@points.each do |point|
			if this_point.x != point.x or this_point.y != point.y  
				if (this_point.x - point.x).abs < 2 and (this_point.y - point.y).abs < 2
					neighbours += 1
				end
			end
		end
		this_point.set_neighbours = neighbours
	end
end



describe "Point" do
	describe ".initialize" do
		it "should return x,y " do
			point = Point.new(1,2)
			expect(point.x).to eq 1
			expect(point.y).to eq 2
		end
	end

end

describe "World" do
	context "empty world" do
		before do
			@world = World.new
			@world.add_point(Point.new(1,2))
			@world.add_point(Point.new(3,4))
		end		
		describe ".initialize" do
			it "should initialise with a point" do
				expect(@world.points[0].x).to eq 1
				expect(@world.points[0].y).to eq 2
			end
		end
	end
	context "world with one point" do
		before do
			@world = World.new
			@world.add_point(Point.new(1,2))
		end		
		describe ".initialize" do
			it "should initialise with a point" do
				expect(@world.points[0].x).to eq 1
				expect(@world.points[0].y).to eq 2
			end
		end
		describe ".find_neighbours" do
			it "should find neighbours" do
				@world.find_neighbours(Point.new(1,2))
				expect(@world.points[0].neighbours).to eq 0
			end
		end
	end
end
class Point 
	attr_reader :x, :y, :neighbours, :future_state
	def initialize(x,y)
		@x = x
		@y = y
		@neighbours = 0
		@current_state = :alive
		@future_state = :dead
	end

	def set_neighbours(neighbours)
		@neighbours = neighbours
	end

	def set_future_state(future_state)
		@future_state = future_state
	end

	def calc_future_state()
		case @neighbours
		when 0..1 then @future_state = :dead
		when 2..3 then @future_state = :alive
		else @future_state = :dead
		end
	end

end

class World
	attr_reader :points
	def initialize()
		@points = []
	end

	def add_point(point)
		@points.push(point)
	end

	def get_neighbours(index) # get the neighbours for one point
		neighbours = 0
		@points.each do |point|
			if @points[index].x != point.x or @points[index].y != point.y 				
				if (@points[index].x - point.x).abs < 2 and (@points[index].y - point.y).abs < 2
					neighbours += 1
				end
			end 
			@points[index].set_neighbours(neighbours)
		end
	end
	def populate_all_neighbours 
		for i in 0..@points.length-1
			self.get_neighbours(i)
		end
	end

	def populate_future_state
		@points.each do |point|
			point.calc_future_state
		end
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
	describe ".calc_future_state" do
		context "various futures" do
			before do
				@point = Point.new(1,2)
			end
			it "should return a future state of :dead when new point" do
				@point.calc_future_state
				expect(@point.future_state).to eq :dead
			end
			it "should return a future state of :alive when one neighbour" do
				@point.set_neighbours(1)
				@point.calc_future_state			
				expect(@point.future_state).to eq :dead
			end	
			it "should return a future state of :alive when two neighbour" do
				@point.set_neighbours(2)
				@point.calc_future_state			
				expect(@point.future_state).to eq :alive
			end	
			it "should return a future state of :dead when fours neighbours" do
				@point.set_neighbours(4)
				@point.calc_future_state			
				expect(@point.future_state).to eq :dead
			end
		end
	end
end

describe "World" do
	context "empty world" do
		before do
			world = World.new
			world.add_point(Point.new(1,2))
			world.add_point(Point.new(3,4))
		end		
		describe ".initialize" do
			it "should initialise with a point" do
				expect(world.points[0].x).to eq 1
				expect(world.points[0].y).to eq 2
			end
		end
		describe ".add_point" do
			it "should add a second point" do
				expect(world.points[1].x).to eq 3
				expect(world.points[1].y).to eq 4
			end
		end

	end
	describe ".get_neighbours" do
		it "should return the correct number of neighbours when there is one" do
			world = World.new
			world.add_point(Point.new(1,2))
			world.add_point(Point.new(1,1))
			world.get_neighbours(0)
			world.get_neighbours(1)
			expect(world.points[0].neighbours).to eq 1
			expect(world.points[1].neighbours).to eq 1
		end	
		it "should return the correct number of neighbours when there are two" do
			world = World.new
			world.add_point(Point.new(1,1))
			world.add_point(Point.new(1,2))
			world.add_point(Point.new(1,0))
			world.get_neighbours(0)
			expect(world.points[0].neighbours).to eq 2
		end
	end

	context " (world with one point)" do
		before do
			@world = World.new
			@world.add_point(Point.new(1,2))		
			@world.populate_all_neighbours
		end
		describe ".populate_all_neighbours" do
			it "should return the correct number of neighbours" do
				expect(@world.points[0].neighbours).to eq 0
			end
		end	
		describe ".populate_future_state" do
			it "should return the correct future state" do
				@world.populate_future_state
				expect(@world.points[0].future_state).to eq :dead
			end
		end
	end

	context "(world with two points)" do
		before do
			@world = World.new
			@world.add_point(Point.new(1,2))		
			@world.add_point(Point.new(1,1))
			@world.populate_all_neighbours
		end
		describe ".populate_all_neighbours" do
			it "should return the correct number of neighbours" do
				expect(@world.points[0].neighbours).to eq 1
				expect(@world.points[1].neighbours).to eq 1
			end	
		end
		describe ".populate_future_state" do
			it "should return the correct future state" do
				@world.populate_future_state
				expect(@world.points[0].future_state).to eq :dead
				expect(@world.points[1].future_state).to eq :dead
			end
		end
	end

	context "(world with three adjacent points)" do
		before do
			@world = World.new
			@world.add_point(Point.new(1,1))
			@world.add_point(Point.new(1,2))		
			@world.add_point(Point.new(1,3))
			@world.populate_all_neighbours
		end
		describe ".populate_all_neighbours" do
			it "should return the correct number of neighbours" do
				expect(@world.points[0].neighbours).to eq 1
				expect(@world.points[1].neighbours).to eq 2
				expect(@world.points[2].neighbours).to eq 1
			end
		end
		describe ".populate_future_state" do
			it "should return the correct future state" do
				@world.populate_future_state
				expect(@world.points[0].future_state).to eq :dead
				expect(@world.points[1].future_state).to eq :alive
				expect(@world.points[2].future_state).to eq :dead
			end
		end
	end
end
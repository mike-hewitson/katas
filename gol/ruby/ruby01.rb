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

	def get_neighbours(index) 
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

	def create_new_world
		new_world = World.new
		@points.each do |point|
			if point.future_state == :alive
				new_world.add_point(point)
			end
		end
		return new_world
	end

	def list(heading)
		puts heading
		@points.each do |point|
			puts "Point x = #{point.x} y = #{point.y} neighbours = #{point.neighbours} future_state = #{point.future_state}"
		end
	end

	def num_points_in_world
		return @points.length
	end

end

world = World.new
world.add_point(Point.new(0,0))
world.add_point(Point.new(1,0))		
world.add_point(Point.new(-1,0))
world.add_point(Point.new(0,1))
world.add_point(Point.new(0,-1))
world.list("before anything")
world.populate_all_neighbours
world.populate_future_state
new_world = world.create_new_world
new_world.list("the new world")
new_world.populate_all_neighbours
new_world.populate_future_state
newer_world = new_world.create_new_world
newer_world.list("the newer world")


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
		describe ".add_point" do
			it "should add a second point" do
				expect(@world.points[1].x).to eq 3
				expect(@world.points[1].y).to eq 4
			end
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
		describe ".create_new_world" do
			it "should return the an empty world" do
				@world.populate_future_state
				new_world = @world.create_new_world
				expect(new_world.num_points_in_world).to eq 0
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
		describe ".get_neighbours" do
			it "should return the correct number of neighbours when there is one" do
				@world.get_neighbours(0)
				@world.get_neighbours(1)
				expect(@world.points[0].neighbours).to eq 1
				expect(@world.points[1].neighbours).to eq 1
			end	
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
		describe ".get_neighbours" do
			it "should return the correct number of neighbours when there are two" do
				@world.get_neighbours(1)
				expect(@world.points[1].neighbours).to eq 2
			end
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
		describe ".create_new_world" do
			it "should return the correct new world with one point" do
				@world.populate_future_state
				@new_world = @world.create_new_world
				expect(@new_world.num_points_in_world).to eq 1
				expect(@new_world.points[0].x).to eq 1
				expect(@new_world.points[0].y).to eq 2
			end
		end
	end	
	context "(world with five adjacent points)" do
		before do
			@world = World.new
			@world.add_point(Point.new(0,0))
			@world.add_point(Point.new(1,0))		
			@world.add_point(Point.new(-1,0))
			@world.add_point(Point.new(0,1))
			@world.add_point(Point.new(0,-1))
			@world.populate_all_neighbours
		end
		describe ".create_new_world" do
			it "should return the correct new world with one point" do
				@world.populate_future_state
				@new_world = @world.create_new_world
				expect(@new_world.num_points_in_world).to eq 4
			end
		end
	end
end
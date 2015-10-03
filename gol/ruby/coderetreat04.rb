require "set"

Coordinate = Struct.new(:x, :y) 

def adjacent?(a,b)
	(a.x - b.x).abs < 2 and (a.y - b.y).abs < 2
end


class World
	attr_reader :cells
	def initialize
		@cells = Set.new
	end

	def add_point(cell)
		@cells << cell
	end

	def contains?(cell)
		@cells.member?(cell)
	end

	def neighbours(cell)
		@cells.select{|c| adjacent?(cell, c)}.count() - 1
	end

	def create_candidates
		@candidates = Set.new
		@cells.each do |cell|
			for x in cell.x - 1 .. cell.x + 1
				for y in cell.y - 1 .. cell.y + 1
					@candidates << Coordinate.new(x,y)
				end
			end
		end
		@candidates = @candidates.select{|cell| !self.contains?(cell)}

	end

	def tick
		new_world = Set.new
		@cells.select{|c| self.neighbours(c) < 2}.each do |cell|
			new_world << cell
		end
		self.create_candidates
		puts @candidates.size


		puts @candidates.select{|c| self.neighbours(c) == 3}.size

		@candidates.select{|c| self.neighbours(c) == 3}.each do |cell|
			puts "hello"
			new_world << cell
		end			
	end
end


describe "World" do
	context "empty" do
		before do
			@world = World.new
			@world.add_point(Coordinate.new(1,2))
			@world.add_point(Coordinate.new(3,4))
		end		
		describe ".initialize" do
			it "should initialise with a coordinate" do
				expect(@world.contains?(Coordinate.new(1,2))).to eq true
			end
		end
	end
	context "with three cells" do
		before do
			@world = World.new
			@world.add_point(Coordinate.new(1,0))
			@world.add_point(Coordinate.new(1,1))
			@world.add_point(Coordinate.new(1,2))
		end		
		describe ".neighbours" do
			it "should return the number of neighbours" do
				expect(@world.neighbours(Coordinate.new(1,0))).to eq 1
				expect(@world.neighbours(Coordinate.new(1,1))).to eq 2
				expect(@world.neighbours(Coordinate.new(1,2))).to eq 1
			end
		end
	end
	context "with vertical bar" do
		before do
			@world = World.new
			@world.add_point(Coordinate.new(1,0))
			@world.add_point(Coordinate.new(1,1))
			@world.add_point(Coordinate.new(1,2))
		end		
		describe ".tick" do
			it "should return a hrizontal bar" do
				@world.tick
				expect(@world.contains?(Coordinate.new(0,1))).to eq true
				expect(@world.contains?(Coordinate.new(1,1))).to eq true
				expect(@world.contains?(Coordinate.new(2,1))).to eq true
			end
		end
	end
end

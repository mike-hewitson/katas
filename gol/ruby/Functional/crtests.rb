require "set"
require "./crcore.rb"

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
				expect(@world.contains?(Coordinate.new(1,0))).to eq false
				expect(@world.contains?(Coordinate.new(1,1))).to eq true
				expect(@world.contains?(Coordinate.new(2,1))).to eq true
				expect(@world.contains?(Coordinate.new(1,2))).to eq false
			end
		end
	end
end

Coordinate = Struct.new(:x, :y) 
Cell = Struct.new(:Coordinate)

# class Cell
#   def initialize(coord)
# end



describe "Cell" do
	describe ".initialize" do
		it "should return x,y " do
			cell = Cell.new(Coodinates.new(1,2))
			expect(cell.coordinates).to eq Coordinates.new(1,2)
		end
	end

	end
end

# describe "World" do
# 	context "empty world" do
# 		before do
# 			world = World.new
# 			world.add_point(Point.new(1,2))
# 			world.add_point(Point.new(3,4))
# 		end		
# 		describe ".initialize" do
# 			it "should initialise with a point" do
# 				expect(world.points[0].x).to eq 1
# 				expect(world.points[0].y).to eq 2
# 			end
# 		end
# 	end
# end
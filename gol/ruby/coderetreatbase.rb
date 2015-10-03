class Point 
	attr_reader :x, :y, :current_state
	def initialize(x,y)
		@x = x
		@y = y
		@current_state = :alive
	end
end

class World

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
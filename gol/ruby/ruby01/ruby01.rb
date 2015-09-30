class Point 
	attr_reader :x, :y
	def initialize(x,y)
		@x=x
		@y=y
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
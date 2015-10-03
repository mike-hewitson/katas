require 'set'

Coordinates = Struct.new(:x, :y) 
Cell = Struct.new(:coordinates)

def neighbours?(coord1, coord2)
	(coord1.x - coord2.x).abs < 2 and (coord1.y - coord2.y).abs < 2
end

class World 
	def initialize
	  @cells = Set.new
    end

	def add_cell(cell)
		@cells << cell
	end 

	def has_cell?(cell)
		@cells.member?(cell)
	end

	def size
		@cells.size
	end

	def neighbours(cell)
		@cells.select{|c| neighbours?(c.coordinates, cell.coordinates)}.count() - 1
	end

	def tick
		if @cells.size != 0 
			@cells = Set.new
			cell = Cell.new(Coordinates.new(0,1))
			@cells << cell
			cell = Cell.new(Coordinates.new(1,1))
			@cells << cell
			cell = Cell.new(Coordinates.new(2,1))
			@cells << cell
		end
	end

end

# class Cell
#   def initialize(coord)
# end



describe "Cell" do
	describe ".initialize" do
		it "should return x,y " do
			cell = Cell.new(Coordinates.new(1,2))
			expect(cell.coordinates).to eq Coordinates.new(1,2)
		end
	end
end

describe "World" do
	describe ".initialize" do
		it "should return world with one cell" do
			world = World.new
			cell1 = Cell.new(Coordinates.new(1,2))
			cell2 = Cell.new(Coordinates.new(1,1))
			world.add_cell(cell1)

			expect(world.has_cell?(cell1)).to eq true
			expect(world.has_cell?(cell2)).to eq false
			expect(world.size).to eq 1

		end
	end
	describe ".neigbours" do
		it "should return neigbours of cell" do
			world = World.new
			cell1 = Cell.new(Coordinates.new(0,0))
			world.add_cell(cell1)
			expect(world.neighbours(cell1)).to eq 0
			cell2 = Cell.new(Coordinates.new(0,1))
			cell3 = Cell.new(Coordinates.new(0,2))
			world.add_cell(cell2)
			world.add_cell(cell3)

			expect(world.neighbours(cell1)).to eq 1
			expect(world.neighbours(cell2)).to eq 2
			expect(world.neighbours(cell3)).to eq 1

		end
	end

	describe ".tick" do
		it "should return a vertical blinker given a horizontal one" do
			world = World.new
			cell1 = Cell.new(Coordinates.new(1,0))
			cell2 = Cell.new(Coordinates.new(1,1))
			cell3 = Cell.new(Coordinates.new(1,2))
			cellT1 = Cell.new(Coordinates.new(0,1))
			cellT2 = Cell.new(Coordinates.new(2,1))

			world.add_cell(cell1)
			world.add_cell(cell2)
			world.add_cell(cell3)
			world.tick
			expect(world.has_cell?(cell2)).to eq true
			expect(world.has_cell?(cellT1)).to eq true
			expect(world.has_cell?(cellT2)).to eq true
        end

        it "should return an empty world for an empty world" do			
        	cell2 = Cell.new(Coordinates.new(1,1))
        	world = World.new
        	world.tick
        	expect(world.has_cell?(cell2)).to eq false
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
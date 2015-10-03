require "set"

Coordinate = Struct.new(:x, :y) 

class Cell 
	attr_reader :coordinate
	def initialize(x,y)
		@coordinate = Coordinate.new(x,y)
	end

	def eql(point)
		self.coordinate = point.coordinate
	end

	def adjacent_to?(cell)
		(cell.coordinate.x - self.coordinate.x).abs < 2 and (cell.coordinate.y - self.coordinate.y).abs < 2 and !(self.coordinate == cell.coordinate)
	end


end

class World
	attr_reader :points
	def initialize
		@cells = Set.new
	end

	def add_cell(cell)
		@cells.add(cell)
	end

	def has_cell(cell)
		@cells.member?(cell)
	end

	def neighbours_for(cell)
		@cells.select{|c| c.adjacent_to?(cell)}.count()
	end

	def create_set_of_nascent_cells
		nascent_cells = Set.new
		@cells.each do |cell|
				nascent_cells.merge(cell.dead_neigbours)
		end
		nascent_cells
	end
end


describe "Cell" do
	describe ".initialize" do
		it "should return coordinate " do
			cell = Cell.new(1,2)
			expect(cell.coordinate).to eq Coordinate.new(1,2)
		end
	end
end

describe "World " do
	context "empty" do
		before do
			@world = World.new
			@cell1 = Cell.new(1,2)
			@world.add_cell(@cell1)
		end		
		describe ".initialize" do
			it "with a cell" do
				expect(@world.has_cell(@cell1)).to eq true
			end
		end
	end
	context "populated" do
		before do
			@world = World.new
			@cell1 = Cell.new(0,0)
			@world.add_cell(@cell1)
			@cell2 = Cell.new(0,1)
			@world.add_cell(@cell2)
			@cell3 = Cell.new(0,2)
			@world.add_cell(@cell3)
		end		
		describe ".neighbours_for" do
			it "should return the neighbours given cell" do
				expect(@world.neighbours_for(@cell1)).to eq 1
				expect(@world.neighbours_for(@cell2)).to eq 2
				expect(@world.neighbours_for(@cell3)).to eq 1
			end
		end
	end
end
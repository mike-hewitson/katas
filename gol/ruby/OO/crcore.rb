require "set"

Coordinate = Struct.new(:x, :y) 
NEIGHBOUR_LIST = [[-1,-1], [-1,0], [-1,1], [0, -1], [0, 1], [1,-1], [1,0], [1,1]]

def adjacent?(a,b)
	(a.x - b.x).abs < 2 and (a.y - b.y).abs < 2
end

class World
	attr_reader :cells
	def initialize
		@cells = Set.new
		@candidates = Set.new
	end

	def contains?(cell)
		@cells.member?(cell)
	end

	def neighbours(cell)
		NEIGHBOUR_LIST.map{|p| Coordinate.new(p[0]+cell.x, p[1]+cell.y)}.to_set
	end	

	def neighbours_count(cell)
		self.neighbours(cell).select{|c| @cells.member?c and cell != c}.length
	end

	def create_candidates
		@candidates = @cells.map{|cell| self.neighbours(cell)}.inject(&:merge).subtract(@cells)
	end

	def tick
		new_world = Set.new

		@cells.select{|c| self.neighbours_count(c).between?(2,3)}.each do |cell|
			new_world << cell
		end

		self.create_candidates

		@candidates.select{|c| self.neighbours_count(c) == 3}.each do |cell|
			new_world << cell
		end

		@cells = new_world

	end

	def size
		size = @cells.map{|cell| [cell.x.abs, cell.y.abs].max}.max
		return size * 2 + 20
	end

	def start_world(shape)
		@cells = shape
	end

	def print_me
		puts "world"
		@cells.each do |cell|
			puts "x = #{cell.x} y = #{cell.y} neighbours #{self.neighbours(cell)}"
		end
		puts "-----#{@cells.size}-----"
	end

end


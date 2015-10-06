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

	def contains?(cell)
		@cells.member?(cell)
	end

	def neighbours(cell)
		# @cells.select{|c| adjacent?(cell, c)}.count() - 1
		neighbours = 0
		for x in cell.x - 1 .. cell.x + 1
			for y in cell.y - 1 .. cell.y + 1
				if @cells.include?(Coordinate.new(x,y))
					neighbours += 1
				end
			end
		end
		return neighbours - 1
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

		@candidates.subtract(@cells)
	end

	def tick
		new_world = Set.new
		puts "Checking who lives #{Time.now}"
		@cells.select{|c| self.neighbours(c).between?(2,3)}.each do |cell|
			new_world << cell
		end

		puts "Creating candidates #{Time.now}"
		self.create_candidates

		puts "Checking who comes alive lives #{Time.now}"
		@candidates.select{|c| self.neighbours(c) == 2}.each do |cell| #this has been reduced by one as the cell has itself as neighbours
			new_world << cell
		end

		@cells = new_world
		
		puts "Done #{Time.now}"

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


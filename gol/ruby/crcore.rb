require "set"

Coordinate = Struct.new(:x, :y) 

def neighbours(cell)
	adjacent_list = Set.new()
	for x in cell.x - 1 .. cell.x + 1
		for y in cell.y - 1 .. cell.y + 1
			adjacent_list << Coordinate.new(x,y)
		end
	end
	return adjacent_list.subtract(cell)
end

def neighbours_count(cell, cells)
	neighbours = 0
	for x in cell.x - 1 .. cell.x + 1
		for y in cell.y - 1 .. cell.y + 1
			if cells.member?(Coordinate.new(x,y))
				if cell != Coordinate.new(x,y)
					neighbours += 1
				end
			end
		end
	end
	return neighbours 
end

def create_candidates(cells)
	candidates = Set.new
	cells.each {|cell| candidates << neigbours(cell)}
	return candidates.subtract(cells)
end

def tick(cells)
	new_world = Set.new
	new_world = cells.select{|c| neighbours(c).between?(2,3)}
	new_world = create_candidates.select{|c| neighbours(c) == 3}
	return new_world
end

def size(cells)
	cells.map{|cell| [cell.x.abs, cell.y.abs].max}.max * 2 + 20
end

def print_me(cells)
	puts "world"
	cells.each do |cell|
		puts "x = #{cell.x} y = #{cell.y} neighbours #{self.neighbours(cell)}"
	end
	puts "-----#{@cells.size}-----"
end



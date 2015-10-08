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
	count = 0
	for x in cell.x - 1 .. cell.x + 1
		for y in cell.y - 1 .. cell.y + 1
			if cells.member?(Coordinate.new(x,y))
				if cell != Coordinate.new(x,y)
					count += 1
				end
			end
		end
	end
	return count 
end

def create_candidates(cells)
	cells.map{|cell| neighbours(cell)}.inject(&:merge).subtract(cells)
end

def world_tick(cells)
		(cells.select{|c| neighbours_count(c, cells).between?(2,3)} | 
		 create_candidates(cells).select{|c| neighbours_count(c, cells) == 3}).to_set
end

def size(cells)
	cells.map{|cell| [cell.x.abs, cell.y.abs].max}.max * 2 + 20
end

def print_me(cells, name="world")
	puts name
	cells.each do |cell|
		puts "x = #{cell.x} y = #{cell.y} neighbours #{neighbours_count(cell, cells)}"
	end
	puts "-----#{cells.size}-----"
end



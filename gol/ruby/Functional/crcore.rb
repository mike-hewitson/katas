require 'set'

Coordinate = Struct.new(:x, :y)
NEIGHBOUR_LIST = [[-1, -1], [-1, 0], [-1, 1], [0, -1],
                  [0, 1], [1, -1], [1, 0], [1, 1]]

def neighbours(cell)
  NEIGHBOUR_LIST.map { |p| Coordinate.new(p[0] + cell.x, p[1] + cell.y) }
    .to_set
end

def neighbours_count(cell, cells)
  neighbours(cell).count { |c| (cells.member? c) && (cell != c) }
end

def create_candidates(cells)
  cells.map { |cell| neighbours(cell) }.inject(&:merge).subtract(cells)
end

def world_tick(cells)
  (cells.select { |c| neighbours_count(c, cells).between?(2, 3) } |
    create_candidates(cells)
    .select { |c| neighbours_count(c, cells) == 3 }).to_set
end

def size(cells)
  cells.map { |cell| [cell.x.abs, cell.y.abs].max }.max * 2 + 20
end

def center(cells)
  x = cells.inject(0) { |_, cell| + cell.x }
  y = cells.inject(0) { |_, cell| + cell.y }
  Coordinate.new(x, y)
end

def print_me(cells, name = 'world')
  puts name
  cells.each do |c|
    puts "x = #{c.x} y = #{c.y} neighbours #{neighbours_count(c, cells)}"
  end
  puts "-----#{cells.size}-----"
end

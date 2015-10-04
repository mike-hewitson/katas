require 'set'
require "./crcore.rb"
require 'gosu'

WINDOW_SIZE = 800

class GameWindow < Gosu::Window
	def initialize
		super WINDOW_SIZE, WINDOW_SIZE
		self.caption = "Game of Life"
	end

	def update
	end

	def draw
		size = world.size
		ratio = WINDOW_SIZE / size
		world.cells.each do |cell|
			x = cell.x * ratio
			y = cell.y * ratio
			draw_rect(x,y,ratio, ratio, 0xff_ffffff)
		end
	end
end

Coordinate = Struct.new(:x, :y) 

SQUARE = Set.new << Coordinate.new(1,0) << Coordinate.new(1,1) << Coordinate.new(0,0) << Coordinate.new(0,1)
BLINKER = Set.new << Coordinate.new(1,0) << Coordinate.new(1,1) << Coordinate.new(1,2)
TOAD = Set.new << Coordinate.new(1,0) << Coordinate.new(1,1) << Coordinate.new(1,2) << Coordinate.new(1,3) << Coordinate.new(0,1) << Coordinate.new(0,2) << Coordinate.new(0,4) << Coordinate.new(0,4)


world = World.new
world.start_world(SQUARE)
window = GameWindow.new
window.show
puts "before tick"
world.print_me

while world.tick	
	puts "after tick"
	world.print_me
	sleep 2
end
puts "WORLD STATIC NOW"


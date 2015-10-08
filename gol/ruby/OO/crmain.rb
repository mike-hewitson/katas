require 'set'
require './crcore.rb'
require 'gosu'
require 'csv'

WINDOW_SIZE = 800

class GameWindow < Gosu::Window
	def initialize
		super WINDOW_SIZE, WINDOW_SIZE
		self.caption = "Game of Life - " + ARGV.first
		@color = Gosu::Color.new(0xff_ffffff)
		@world = World.new
		filename = "../data/" + ARGV.first + "_106.lif"
		load_shape = Set.new
		CSV.foreach(filename, { :col_sep => ' '}) do |row|
			if row[0] != '#Life' 
				load_shape << Coordinate.new(row[0].to_i, row[1].to_i)
			end
		end
		@world.start_world(load_shape)
	end

	def update
	end

	def draw
		thing_size = [@world.size, 40].max
		ratio = WINDOW_SIZE / thing_size
		@world.cells.each do |cell|
			x = cell.x * ratio + 400 - thing_size / 2
			y = cell.y * ratio + 400 - thing_size / 2
			Gosu.draw_rect(x,y,ratio, ratio, @color)
		end
		sleep 0.5
		@world.tick
	end
end

window = GameWindow.new
window.show

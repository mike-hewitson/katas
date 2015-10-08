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
		filename = "../data/" + ARGV.first + "_106.lif"
		@cells = Set.new
		CSV.foreach(filename, { :col_sep => ' '}) do |row|
			if row[0] != '#Life' 
				@cells << Coordinate.new(row[0].to_i, row[1].to_i)
			end
		end
	end

	def update
	end

	def draw
		thing_size = [size(@cells), 40].max
		ratio = WINDOW_SIZE / thing_size
		@cells.each do |cell|
			x = cell.x * ratio + 400
			y = cell.y * ratio + 400
			Gosu.draw_rect(x,y,ratio, ratio, @color)
		end
		sleep 0.5
		@cells = world_tick(@cells)
	end
end

window = GameWindow.new
window.show

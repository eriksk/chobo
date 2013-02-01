module Chobo
	class Commands

		def self.run args
			case args.first
				when "new"
					if args.length > 1
						create(args.last)
					else
						puts "Please supply a name for the game."
						puts "	ex: chobo new my_first_game"
					end
				when "help"
					print_help()
				when nil
					print_help()
				when ""
					print_help()
			end
		end

		private
			def self.print_help
				puts "commands:"
				puts "    help # show help"
				puts "    new [name] # create a new game template"
			end

			def self.create name
				name = name.capitalize
				puts "Creating game #{name}"

				Dir.mkdir('content')
				Dir.mkdir('content/gfx')
				Dir.mkdir('content/audio')
				Dir.mkdir('assets')
				Dir.mkdir('lib')
				Dir.mkdir('lib/behaviors')

				File.open("#{name.downcase}.rb", 'w+') do |f|
					f.write get_main name
				end

				File.open('game_window.rb', 'w+') do |f|
					f.write get_game_window name
				end

				File.open('config.rb', 'w+') do |f|
					f.write get_config name
				end

				File.open('lib/game.rb', 'w+') do |f|
					f.write get_game name
				end

				puts "Run with $ruby #{name.downcase}.rb"
				`ruby #{name.downcase}.rb`
			end

			def self.get_config name
				<<-EOF
module #{name}
	WIDTH = 1280
	HEIGHT = 720
	FULLSCREEN = false
	TITLE = #{name}
	CONTENT_ROOT = 'content'
	CLEAR_COLOR = Chobo.color(255, 255, 255)
end

require_relative 'lib/game'
				EOF
			end

			def self.get_game_window name
				<<-EOF
module #{name}
	class GameWindow < Gosu::Window

		def initialize
			super(WIDTH, HEIGHT, FULLSCREEN)
			self.caption = TITLE
			@game = Game.new self
		end
		
		def update
			dt = 16.0
			@game.update dt
		end

		def draw
			clear
			@game.draw
		end

		def clear
			draw_quad(
				0, 0, CLEAR_COLOR,
				WIDTH, 0, CLEAR_COLOR,
				WIDTH, HEIGHT, CLEAR_COLOR,
				0, HEIGHT, CLEAR_COLOR
			)	
		end
	end
end
				EOF
			end

			def self.get_game name
				<<-EOF
module #{name}
	class Game
		attr_accessor :window

		def initialize window
			@window = window
			@font = Gosu::Font.new(window, Gosu::default_font_name, 64)
			@color = Chobo.color(0,0,0,0)
			@fade_in = 2000
			@process = 0.0
		end

		def update dt
			if @window.button_down? Gosu::KbEscape
				@window.close
			end
			@fade_in -= dt
		end
		
		def draw
			if @fade_in >= 0.0
				@process = (2000.0 - @fade_in) / 2000.0
				@color.alpha = Chobo.qlerp(0, 255, @process).to_i
			end
			@font.draw_rel("/Chobo/", WIDTH / 2.0, HEIGHT / 2.0, 0, 0.5, 0.5, Chobo.qlerp(0.0, 1.0, @process), Chobo.qlerp(0.5, 1.0, @process), @color)
		end
	end
end
				EOF
			end

			def self.get_main name
				<<-EOF
require 'chobo'
require_relative 'config'
require_relative 'game_window'

game_window = #{name}::GameWindow.new
game_window.show
				EOF
			end
	end
end

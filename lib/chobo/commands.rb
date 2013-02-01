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
				puts "TODO: help... ooopsie"
			end

			def self.create name
				name = name.capitalize
				puts "Creating game #{name}"
				puts "Creating directory structure"
				Dir.mkdir('content')
				Dir.mkdir('content/gfx')
				Dir.mkdir('content/audio')
				Dir.mkdir('assets')
				Dir.mkdir('lib')
				Dir.mkdir('lib/behaviors')

				puts "Adding base files"
				
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

				puts "Done! Run with $ruby #{name.downcase}.rb"
			end

			def self.get_config name
				<<-EOF
module #{name}
	WIDTH = 1280
	HEIGHT = 720
	FULLSCREEN = false
	TITLE = #{name}
	CONTENT_ROOT = 'content'
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
			@game.draw
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
		end

		def update dt
		end
		
		def draw
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

module Chobo
	class Entity < GameObject

		attr_accessor :image, :behaviors, :width, :height, :attributes, :time, :color, :flipped

		def initialize(image)
			super()
			@image = image
			@width = image.width
			@height = image.height
			@color = Chobo.color()
			@attributes = {}
			@time = 0.0
			@behaviors = []
			@flipped = false
		end

		def collides? other
			if @position.x - (@width / 2.0) > other.position.x + (other.width / 2.0)
				return false
			end			
			if @position.x + (@width / 2.0) < other.position.x - (other.width / 2.0)
				return false
			end
			if @position.y - (@width / 2.0) > other.position.y + (other.height / 2.0)
				return false
			end			
			if @position.y + (@width / 2.0) < other.position.y - (other.height / 2.0)
				return false
			end			
			return true
		end

		def set_color r = 255, g = 255, b = 255, a = 255	
			@color.red = r
			@color.green = g
			@color.blue = b
			@color.alpha = a
			self		
		end

		def set_attribute attribute, value
			@attributes[attribute] = value
			self
		end

		def add_behavior behavior
			@behaviors.push behavior
			behavior.on_added self
			self
		end

		def remove_behavior behavior
			@behaviors.delete behavior
			behavior.on_removed self
			self
		end

		def get_behavior type
			@behaviors.each do |b|
				if b.is_a? type
					return b
				end				
			end
			nil
		end

		def update dt
			@time += dt
			@behaviors.each{|b| b.update dt, self }
		end
		
		def draw
			if @flipped
				@image.draw_rot(@position.x.to_i, @position.y.to_i, 0, @rotation.to_degrees - 180, @origin.x, @origin.y, @scale.x * -1.0, @scale.y, @color)
			else
				@image.draw_rot(@position.x.to_i, @position.y.to_i, 0, @rotation.to_degrees, @origin.x, @origin.y, @scale.x, @scale.y, @color)
			end
		end	
	end
end
module Chobo
	class GameObject
		attr_accessor :position, :velocity, :origin, :rotation, :scale, :color

		def initialize 
			@position = Vec2.new
			@velocity = Vec2.new
			@origin = Vec2.new(0.5, 0.5)
			@rotation = 0.0
			@scale = Vec2.new(1.0, 1.0)
			@color = Chobo.color()
		end

		def set_position x, y
			@position.x, @position.y = x, y
			self
		end

		def set_velocity x, y
			@velocity.x, @velocity.y = x, y
			self
		end

		def set_scale scale_x, scale_y = nil
			if scale_y
				@scale.x = scale_x
				@scale.y = scale_y
			else
				@scale.x = scale_x
				@scale.y = scale_x
			end
			self			
		end

		def set_rotation rotation
			@rotation = rotation
			self
		end

		def set_color r = 255, g = 255, b = 255, a = 255
			@color.red = r
			@color.green = g
			@color.blue = b
			@color.alpha = a
			self
		end

		def update dt
		end
	end
end
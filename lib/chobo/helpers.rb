module Chobo

	@images = {}

	def self.load_image(window, name)
		return @images[name] if @images[name]
		return @images[name] = Gosu::Image.new(window, "#{CONTENT_ROOT}/gfx/#{name}.png")
	end

	def self.load_tiles(window, name, tile_width, tile_height)
		Gosu::Image.load_tiles(window, "#{CONTENT_ROOT}/gfx/#{name}.png", tile_width, tile_height, true)
	end

	def self.load_sample(window, name)
		Gosu::Sample.new(window, "#{CONTENT_ROOT}/audio/#{name}.wav")
	end

	def self.load_song(window, name)
		Gosu::Song.new(window, "#{CONTENT_ROOT}/audio/#{name}.wav")
	end

	def self.color(r = 255, g = 255, b = 255, a = 255)
		clr = Gosu::Color.new
		clr.red = r
		clr.green = g
		clr.blue = b
		clr.alpha = a
		clr		
	end

	def self.wrap_angle(angle)
		while angle > 360.to_radians
			angle -= 360.to_radians
		end
		while angle < 0.0
			angle += 360.to_radians
		end
		angle
	end

	def self.lerp_angle from, to, frac
	    if to - from > 180.to_radians
	        to -= 360.to_radians
	    end
	    if to - from < -180.to_radians
	        to += 360.to_radians
	    end
		from + frac * (to - from)
	end

	# linear interpolation
	def self.lerp x, y, w
		x + (y - x) * w		
	end

	# cubic interpolation using a hermite spline, aka smooth step
	def self.qlerp(min, max, weight)
		hermite(min, 0.0, max, 0.0, weight)
	end

	# value1, tangent1, value2, tangent2
	def self.hermite(v1, t1, v2, t2, weight)
		sCubed = weight * weight * weight
		sSquared = weight * weight
		result = 0.0
		if weight == 0.0
			result = v1
		elsif weight == 1.0
			result = v2
		else
			result = (2 * v1 - 2 * v2 + t2 + t1) * sCubed + (3 * v2 - 3 * v1 - 2 * t1 - t2) * sSquared + t1 * weight + v1
		end
	    result
	end

	def self.clamp(value, min, max)
		return min if value < min
		return max if value > max
		value
	end
end

class Numeric
	def to_degrees
		self * 180.0 / Math::PI
	end

	def to_radians
		self * Math::PI / 180.0
	end
end
module Chobo
	class Animation

		attr_accessor :frames, :interval

		def initialize frames, interval, looping = true
			@frames = frames
			@interval = interval
			@looping = looping
			@state = :running
			reset()
		end

		def reset
			@current = 0.0
			@current_frame = 0
			@state = :running
		end

		def update dt
			if @state == :running
				@current += dt
				if @current > @interval
					@current_frame += 1
					if @current_frame > @frames.size - 1
						if @looping
							reset()
						else
							@state = :stopped
						end
					end
				end
			end
		end
		
		def frame
			@frames[@current_frame]
		end
	end
end
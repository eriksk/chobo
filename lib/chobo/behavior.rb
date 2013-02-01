module Chobo
	class Behavior
		def on_added game_object
			# called when added to a game_object
		end

		def on_removed game_object
			# called when removed from a game_object
		end

		def update dt, game_object
		end	
	end
end
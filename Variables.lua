local Variables = {
	get_input = function ()
		return {
			left = love.keyboard.isDown("left"),
			right = love.keyboard.isDown("right"),
			up = love.keyboard.isDown("up"),
			down = love.keyboard.isDown("down"),
			escape = love.keyboard.isDown("escape"),
		}
	end
}

return Variables
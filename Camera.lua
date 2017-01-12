local Movable = require 'Movable'
local Consts = require 'Consts'
local Camera = Movable.new()


Camera.size = {
	x = Consts.window.width,
	y = Consts.window.height
}

function Camera:is_visible(entity)
	return 
end


return Camera 

local Consts = require "Consts"
local Debug = {}

local function text_printer(text, width, height)
	for i , v in ipairs(text) do
		love.graphics.print(v[1] .. " " .. v[2], width, height + i * 14)
	end
end

function Debug.show_movement(moveable, width, height)
	if not width then
		width = 500
	end
	if not height then
		height = 50
	end
	text_printer({
		{"y position:", moveable.position.y},
		{"x position:", moveable.position.x},
		{"x velocity:", moveable.velocity.x},
		{"y velocity:", moveable.velocity.y},
	}, width, height)
end

function Debug.show_screen_consts(width, height)
	if not width then
		width = 500
	end
	if not height then
		height = 50
	end

	text_printer({
		{"screen width:", Consts.window.width},
		{"screen height:", Consts.window.height}
	}, width, height)
end

return Debug

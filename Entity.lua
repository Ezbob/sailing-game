local Entity = {}


function Entity.new(x, y, width, height, drawable)
	local new_entity = {}

	-- ze world position
	new_entity.position = { 
		x = x and x or 0, 
		y = y and y or 0
	}
	new_entity.size = {
		x = width and width or 0,
		y = height and height or 0
	}

	if drawable ~= nil then
		new_entity.drawable = drawable
	end

	Entity.__index = Entity
	return setmetatable(new_entity, Entity)
end

function Entity:draw()
	if self.drawable ~= nil then
		local scale_x, scale_y
		if self.drawable:typeOf("Image") then
			scale_x = self.size.x / self.drawable:getWidth()
			scale_y = self.size.y / self.drawable:getHeight()
			love.graphics.draw(self.drawable, self.position.x, self.position.y, 0, scale_x, scale_y)
		elseif self.drawable:typeOf("SpriteBatch") then
			scale_x = self.size.x / (self.drawable:getTexture():getWidth() / self.drawable:getCount())
			scale_y = self.size.y / (self.drawable:getTexture():getHeight() / self.drawable:getCount())

			image = self.drawable:getTexture()
			quad = love.graphics.newQuad(x, y, width, height, sw, sh)

			love.graphics.draw(self.drawable, self.position.x, self.position.y, 0, scale_x, scale_y)
		else
			scale_y = 0
			scale_x = 0
			love.graphics.draw(self.drawable, self.position.x, self.position.y, 0, scale_x, scale_y)
		end
	end
end

function Entity:bounding_box()
	return {
		lower = {
			x = self.position.x + self.size.x,
			y = self.position.y - self.size.y
		},
		upper = self.position
	}
end

function Entity:__tostring()
	return "curPos(".. self.position.x .. ", " .. self.position.y ..")"
end

return Entity
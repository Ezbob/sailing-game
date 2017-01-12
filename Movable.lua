local Consts = require "Consts"
local Entity = require "Entity"
local Movable = Entity.new()


function Movable.new(position, step, limits, drawable)
	local new_max_x, new_max_y, new_min_y, new_min_x
	local new_step_x, new_step_y
	local new_x, new_y

	if position ~= nil then
		new_x = position.x and position.x or 0
		new_y = position.y and position.y or 0
	else
		new_x = 0
		new_y = 0
	end

	if step ~= nil then
		new_step_y = step.y and step.y or Consts.defaultStep
		new_step_x = step.x and step.x or Consts.defaultStep
	else
		new_step_y = Consts.defaultStep
	   	new_step_x = Consts.defaultStep
	end

	if limits ~= nil then
		new_max_y = limits.max_y and limits.max_y or Consts.maximumVelocity
		new_max_x = limits.max_x and limits.max_x or Consts.maximumVelocity 
		new_min_y = limits.min_y and limits.min_y or Consts.minimumVelocity
		new_min_x = limits.min_x and limits.min_x or Consts.minimumVelocity
	else
	    new_max_y = Consts.maximumVelocity 
	    new_max_x = Consts.maximumVelocity
	    new_min_x = Consts.minimumVelocity
	    new_min_y = Consts.minimumVelocity
	end

	if drawable ~= nil then
		Movable.drawable = drawable
	end

	local new_movable = Entity.new(new_x, new_y)

	new_movable.step = {
		x = new_step_x,
		y = new_step_y
	}
	new_movable.velocity = {
		x = 0,
		y = 0,
		limits = {
			max = { x = new_max_x, y = new_max_y },
			min = { x = new_min_x, y = new_min_y }
		}
	}
	Movable.__index = Movable
	return setmetatable(new_movable, Movable)
end

function Movable:move(delta_time, move_vector)
	if move_vector.y ~= 0 then
		self.velocity.y = math.min(self.velocity.y + self.step.y,  self.velocity.limits.max.y)

		if move_vector.y > 0 then
			self.position.y = self.position.y - self.velocity.y * delta_time
		else
			self.position.y = self.position.y + self.velocity.y * delta_time
		end
	elseif move_vector.x ~= 0 then 
		self.velocity.x = math.min(self.velocity.x + self.step.x, self.velocity.limits.max.x)

		if move_vector.x > 0 then
			self.position.x = self.position.x + self.velocity.x * delta_time
		else
			self.position.x = self.position.x - self.velocity.x * delta_time
		end
	end
end

function Movable:move_left(delta_time)
	self:move(delta_time, {x = -1, y = 0})
end

function Movable:move_right(delta_time)
	self:move(delta_time, {x = 1, y = 0})
end

function Movable:move_up(delta_time)
	self:move(delta_time, {x = 0, y = 1})
end

function Movable:move_down(delta_time)
	self:move(delta_time, {x = 0, y = -1})
end

function Movable:deaccelerate(delta_time, deaccel_vector)
	if deaccel_vector.x then
		self.velocity.x = math.max((self.velocity.x * 0.9) * delta_time, self.velocity.limits.min.x)

		if self.velocity.x < Consts.velocityCutoff.x then
			self.velocity.x = Consts.minimumVelocity
		end
	end

	if deaccel_vector.y then
		self.velocity.y = math.max((self.velocity.y * 0.9) * delta_time, self.velocity.limits.min.y) 
		
		if self.velocity.y < Consts.velocityCutoff.y then
			self.velocity.y = Consts.minimumVelocity
		end
	end
end

function Movable:deaccelerateX(delta_time)
	self:deaccelerate(delta_time, {x = true, y = false})
end

function Movable:deaccelerateY(delta_time)
	self:deaccelerate(delta_time, {x = false, y = true})
end

return Movable
local Movable = require 'Movable'
local Variables = require 'Variables'
local Consts = require 'Consts'
local Debug = require 'Debug'
local Camera = require 'Camera'
local bump = require 'bump/bump'
local anim8 = require 'anim8/anim8'

renderable_entities = {
	player = Movable.new(nil, nil, 
		{ 
			max_y = 60, 
			max_x = 60 
		}, 
		nil, 
		18
	)
}
local image

function love.load()
	renderable_entities.player.size.x = 26
	renderable_entities.player.size.y = 26
	table.insert(renderable_entities, player)
	image = love.graphics.newImage("ass/idle_boat.png")
	renderable_entities.player.grid = anim8.newGrid(188, 150, image:getWidth(), image:getHeight())
	renderable_entities.player.frames = renderable_entities.player.grid(0, "0-18")
	camera = Camera.new()
	love.window.setTitle(Consts.window.title)
	love.window.setMode(Consts.window.width, Consts.window.height, Consts.window.properties)
end

function love.draw()
	love.graphics.setBackgroundColor(23, 123, 231, 100)

	--[[for key, renderable_entity in ipairs(renderable_entities) do
		renderable_entity:draw()
	end]]--
	Debug.show_movement(renderable_entities.player)
	Debug.show_screen_consts(nil, 140)
end

function love.focus(in_focus)
	has_focus = in_focus
end

function love.update(delta_t)

	if not has_focus then return end

	local keys = Variables.get_input()

	if keys.left and keys.right then
	elseif keys.left then
		renderable_entities.player:move_left(delta_t)
	elseif keys.right then
	   	renderable_entities.player:move_right(delta_t)
	end

	if keys.up and keys.down then
	elseif keys.up then
		renderable_entities.player:move_up(delta_t)
	elseif keys.down then
		renderable_entities.player:move_down(delta_t)
	end

	if love.keyboard.isDown("escape") then
		love.event.quit()
	end

	if not (keys.left or keys.right) then 	
		renderable_entities.player:deaccelerateX(delta_t)
	end
	if not (keys.up or keys.down) then
		renderable_entities.player:deaccelerateY(delta_t)
	end
end

function love.resize(width, height)	
end

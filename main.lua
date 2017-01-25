local Movable = require 'Movable'
local Variables = require 'Variables'
local Consts = require 'Consts'
local Debug = require 'Debug'
local bump = require 'bump/bump'
local anim8 = require 'anim8/anim8'

renderable_entities = {}

function love.load()
	table.insert(renderable_entities, Movable.new({26, 26}, nil, 
		{ 
			max_y = 60, 
			max_x = 60 
		}, 
		nil, 
		18
	))
	local player = renderable_entities[1]
	player.spriteSheet = love.graphics.newImage("ass/boat2.png")
	local width, height = player.spriteSheet:getDimensions()
	local grid = anim8.newGrid(188, 150, width, height)
	player.currentAnimation = 'idle'
	player.animation = { 
		idle = { isFlipped = false, animation = anim8.newAnimation(grid("1-18", 1), 0.1) }, 
		sailing = { isFlipped = false, animation = anim8.newAnimation(grid("19-36", 1), 0.1) } 
	}
	love.window.setTitle(Consts.window.title)
	love.window.setMode(Consts.window.width, Consts.window.height, Consts.window.properties)
end

function love.draw()
	local player = renderable_entities[1]
	love.graphics.setBackgroundColor(23, 123, 231, 100)
	Debug.show_movement(player)
	Debug.show_screen_consts(nil, 140)
	player.animation[player.currentAnimation].animation:draw(player.spriteSheet, 
		player.position.x, player.position.y, 0, 0.25, 0.25)
end

function love.focus(in_focus)
	has_focus = in_focus
end

function love.update(delta_t)
	
	local player = renderable_entities[1]
	local animationState = player.animation[player.currentAnimation]
	animationState.animation:update(delta_t)

	if not has_focus then return end

	local keys = Variables.get_input()

	if not keys.left or not keys.right then
		player.currentAnimation = 'idle'
	end

	if keys.left and keys.right then
		player.currentAnimation = 'idle'
	elseif keys.left then
		player.currentAnimation = 'sailing'
		if animationState.isFlipped then
			animationState.animation:flipH()
			animationState.isFlipped = false
		end
		player:move_left(delta_t)
	elseif keys.right then
		player.currentAnimation = 'sailing'
		if not animationState.isFlipped then
			animationState.animation:flipH()
			animationState.isFlipped = true 
		end
	   	player:move_right(delta_t)
	end

	if keys.up and keys.down then
	elseif keys.up then
		player.currentAnimation = 'sailing'
		player:move_up(delta_t)
	elseif keys.down then
		player.currentAnimation = 'sailing'
		player:move_down(delta_t)
	end

	if keys.escape then
		love.event.quit()
	end

	if not (keys.left or keys.right) then 	
		player:deaccelerateX(delta_t)
	end
	if not (keys.up or keys.down) then
		player:deaccelerateY(delta_t)
	end
end

function love.resize(width, height)	
end
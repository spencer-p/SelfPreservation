--
-- title.lua
--

Gamestate = require "hump.gamestate"

titlescreen = {}

function titlescreen:init()
	-- title vars
	self.title = "Self Preservation"
	self.options = { "[enter] to start" }
	self.selected = 1

	-- font
	self.fontimage = love.graphics.newImage("font.png")
	self.fontimage:setFilter("nearest", "nearest")
	self.font = love.graphics.newImageFont(self.fontimage,
		"ABCDEFGHIJKLMNOPQRSTUVWXYZ"..
		"abcdefghijklmnopqrstuvwxyz"..
		"#%&@$.,!?:;'\"()[]*/\\+-<=>"..
		"0123456789 "
	)
	love.graphics.setFont(self.font)

	-- components for title screen
	self.components = {}
	self.components.input = InputComponent(self)
	self.components.graphics = MenuGraphicsComponent(self, colors.blue, colors.blue)
end

function titlescreen:enter(prev, player)
	self.player = player
end

function titlescreen:update(dt)
	for key, component in pairs(self.components) do
		if component.update then
			component:update(dt)
		end
	end
end

function titlescreen:keypressed(key)
	if key == "return" then
		Gamestate.switch(room1, self.player)
	elseif key == "escape" then
		love.event.quit()
	end
end

function titlescreen:draw()
	love.graphics.scale(SCALE)
	for key, component in pairs(self.components) do
		if component.draw then
			component:draw()
		end
	end
end

function titlescreen:send(origin, message) -- For ECS
	for key, value in pairs(self.components) do
		if value.recieve then
			value:recieve(origin, message)
		end
	end
end

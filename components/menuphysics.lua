--[[
	menuphysics.lua
	Not so much physics as it is general handling
]]

Class = require "hump.class"

MenuPhysicsComponent = Class{}

function MenuPhysicsComponent:init(parent, gamestate)
	self.parent = parent
	self.velUpdateSpeed = 0.15
	self.gameStateToEnter = gamestate
	self.counter = 0
end

function MenuPhysicsComponent:update(dt)
	self.counter = self.counter + dt
	if self.parent.vel ~= vector(0, 0) and self.counter > self.velUpdateSpeed then
		self.counter = 0
		if self.parent.vel.y == 1 then
			-- Increment, loop back to 1
			self.parent.selected = self.parent.selected%#self.parent.options + 1
		elseif self.parent.vel.y == -1 then
			self.parent.selected = self.parent.selected-1
			if self.parent.selected <= 0 then
				self.parent.selected = #self.parent.options
			end
		end
	end
end

function MenuPhysicsComponent:recieve(origin, message)
	if message.m == "attack" then
		if self.parent.options[self.parent.selected] == "start" then
			sounds.enter:play()
			if (Gamestate.stackLength() > 2) then
				Gamestate.pop(self.parent.player)
			else
				self.parent.player.points = 0
				Gamestate.switch(self.gameStateToEnter, self.parent.player)
			end
		elseif self.parent.options[self.parent.selected] == "quit" then
			love.event.quit()
		end
	end
end

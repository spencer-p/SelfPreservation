--[[ 
	components.physics.lua
	A physics component
]]

Class = require "hump.class"
vector = require "hump.vector"

PhysicsComponent = Class{}

function PhysicsComponent:init(parent)
	self.parent = parent
	self.oldpos = self.parent.pos:clone()
end

function PhysicsComponent:recieve(sender, message)
	if sender ~= self then
		if message.m == "move" then
			-- Send tick event
			if self.parent.world.player == self.parent then
				self.parent.world:tick()
			end

			newpos = self.parent.pos + message.vector
			entityAtNewPos = self.parent.world:entityAt(newpos)
			if not entityAtNewPos or entityAtNewPos == self.parent then
				-- Move if possible
				self.oldpos = self.parent.pos
				self.parent.pos = newpos
			end

			-- Update facing -- the -1 is entrenched in other places
			self.parent.facing = -1 * message.vector

			-- Zap
			self.parent:send(self.parent, { m = "zap" })
		end
	end
end

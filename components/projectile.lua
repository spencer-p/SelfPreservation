--[[
	projectile.lua
]]

Class = require "hump.class"
require "bullet"

ProjectileComponent = Class{}

function ProjectileComponent:init(parent, damage)
	self.parent = parent
	self.bullets = {}
	self.damage = damage or 1
end

function ProjectileComponent:update(dt)
	for i, b in ipairs(self.bullets) do
		b:update(dt)
		if not b.exists then
			table.remove(self.bullets, i)
		end
	end
end

function ProjectileComponent:draw()
	for i, b in ipairs(self.bullets) do
		b:draw()
	end
end

function ProjectileComponent:recieve(origin, message)
	if message.m == "projectile" and #self.bullets < 3 then
		table.insert(self.bullets, Bullet(self.parent.game, self.parent.pos+self.parent.facing, self.parent.facing, self.damage))
	end
end

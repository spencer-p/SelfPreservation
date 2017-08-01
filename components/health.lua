--[[
	health.lua
]]

Class = require "hump.class"

HealthComponent = Class{}

function HealthComponent:init(parent, hp)
	self.parent = parent
	self.maxhp = hp or 12
	self.hp = self.maxhp
	self.healCounter = 0
end

--function HealthComponent:update(dt)
--end

function HealthComponent:recieve(origin, message)
	if origin == self then return end
	if message.m == "damage" then
		--print(self.parent.type.." taking "..message.damage.." damage!")
		if origin then SOUNDS.hit:play() end
		self.hp = self.hp - message.damage
		if self.hp <= 0 then
			self.parent.dead = true
			self.parent.killedByPlayer = message.from == self.parent.world.player
			self.parent:send(self.parent, { m = "dead" })
		end
	elseif message.m == "heal" then
		self.hp = math.min(self.hp + message.amount, self.maxhp)
	end
end

-- This is the HUD, i guess
-- TODO : learn why you named this userDraw
--function HealthComponent:userDraw()
--end

function HealthComponent:draw()
	if self.parent.world.player == self.parent then
		love.graphics.push()
		love.graphics.origin()
		love.graphics.scale(SCALE)
		love.graphics.setColor(colors.blue)
		for i = 1, self.hp do
			love.graphics.draw(SPRITES:getImg(), SPRITES:getQuad(4, 1), 0, (i-1)*16)
		end

		love.graphics.pop()
	end
end

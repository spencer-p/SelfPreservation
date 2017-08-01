--
-- exploding.lua
--
-- Defines ExplodingComponent, allows things to blow up
--

Class = require "hump.class"

local explodeRange = {
	vector(0, 0),
	vector(0, 1),
	vector(0, -1),
	vector(1, 0),
	vector(-1, 0)
}

ExplodingComponent = Class{}

function ExplodingComponent:init(parent, timeout, color1, color2)
	self.parent = parent
	self.timeout = timeout
	self.ticks = 0
	self.flickerCounter = 0
	self.flickerColors = { color1, color2 }
	self.flickerColor = 1
end

function ExplodingComponent:update(dt)
	if self.exploded then return end
	self.flickerCounter = self.flickerCounter + dt
	local threshold = 1 / ( 10 * self.ticks/self.timeout + 2)
	if self.flickerCounter > threshold then
		self.flickerColor = self.flickerColor % 2 + 1
		self.parent.components.graphics.color = self.flickerColors[self.flickerColor]
		self.flickerCounter = 0
	end
end

function ExplodingComponent:drawUnder()
	if self.exploded then
		love.graphics.setColor(colors.red)
		for _, v in ipairs(explodeRange) do
			love.graphics.draw(SPRITES:getImg(), SPRITES:getQuad(2, 12),
				(16*(self.parent.pos+v)):unpack())
		end
	end
end

function ExplodingComponent:tick()
	self.ticks = self.ticks + 1
	if self.ticks >= self.timeout and not self.exploded then
		self.exploded = true
		SOUNDS.explode:play()
		for _, v in ipairs(explodeRange) do
			entity = self.parent.world:entityAt(self.parent.pos+v)
			if entity then
				entity:send(self.parent, {m = "damage", damage = 4 })
			end
		end
	end
end

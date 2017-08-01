--
-- ROCKEM.lua
--

RockemAIComponent = Class{}

local facings = {
	vector(0, 1),
	vector(0, -1),
	vector(1, 0),
	vector(-1, 0)
}

function RockemAIComponent:init(parent)
	self.parent = parent

	self.ready = false
end

function RockemAIComponent:update(dt)
	if not self.ready then
		-- Determine next location
		repeat
			if math.random(1, 3) == 1 then
				self.parent.facing = facings[math.random(1, 4)]
			end
			local entity = self.parent.world:entityAt(self.parent.pos - self.parent.facing)
		until entity == nil or entity == self.parent.world.player
		self.ready = true
	end
end

function RockemAIComponent:tick()
	local entity = self.parent.world:entityAt(self.parent.pos-self.parent.facing)
	if not entity then
		self.parent.pos = self.parent.pos - self.parent.facing
	else
		self.parent:send(self.parent, { m = "zap" })
	end
	self.ready = false
end

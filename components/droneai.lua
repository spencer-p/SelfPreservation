--
-- dronai.lua
--

DroneAIComponent = Class{}

local facings = {
	vector(0, 1),
	vector(0, -1),
	vector(1, 0),
	vector(-1, 0)
}

function DroneAIComponent:init(parent)
	self.parent = parent

	self.ready = false
end

function DroneAIComponent:update(dt)
	if not self.ready then
		-- Determine next location
		repeat
			if math.random(1, 3) == 1 then
				self.parent.facing = facings[math.random(1, 4)]
			end
			local entity = self.parent.world:entityAt(self.parent.pos - self.parent.facing)
		until entity == nil or not entity.type == "Wall"
		-- Determine if a bomb should be dropped
		self.shouldDropBomb = math.random(1, 5) == 1
		self.ready = true
	end
end

function DroneAIComponent:tick()
	if self.shouldDropBomb then self.parent:send(self.parent, { m = "bomb", location = self.parent.pos }) end
	self.parent.pos = self.parent.pos - self.parent.facing
	self.ready = false
end

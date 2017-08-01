--
-- rockem.lua
-- rockem sockem robot : )
--

Rockem = Class{ type = "Rockem" }
Rockem:include(Entity)

function Rockem:init(world, x, y)
	self.world = world
	self.pos = vector(x, y)
	self.facing = vector(0, 1)

	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.blue, {6, 2})
	self.components.health = HealthComponent(self, 8)
	self.components.zap = ZapperComponent(self, 6)
	self.components.ai = RockemAIComponent(self)
end

--
-- turret.lua
--

Turret = Class{ type = "Turret" }
Turret:include(Entity)

local facings = {
	up = vector(0, 1),
	down = vector(0, -1),
	left = vector(1, 0),
	right = vector(-1, 0)
}

function Turret:init(world, x, y, facing)
	self.world = world
	self.pos = vector(x, y)
	self.facing = facings[facing]

	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.blue, {16, 8})
	self.components.health = HealthComponent(self, 4)
	self.components.turret = TurretComponent(self)
end

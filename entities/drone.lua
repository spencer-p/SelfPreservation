--
-- drone.lua
-- flying based enemy
--
-- TODO
-- Does the drone attack, or spot for the others
--

Drone = Class{ type = "Drone" }
Drone:include(Entity)

function Drone:init(world, x, y)
	self.world = world
	self.pos = vector(x, y)
	self.facing = vector(0, 1)

	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.blue, {8,15})
	self.components.health = HealthComponent(self, 2)
	self.components.pyro = PyroComponent(self)
	self.components.ai = DroneAIComponent(self)
end

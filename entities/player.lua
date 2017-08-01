--
-- player.lua
--

Player = Class{ type = "Player" }
Player:include(Entity)

function Player:init(world, x, y)
	self.world = world
	self.pos = vector(x, y)
	self.facing = vector(0, 1)

	self.dead = false

	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.white, {3, 1})
	self.components.physics = PhysicsComponent(self)
	self.components.input = InputComponent(self)
	self.components.health = HealthComponent(self)
	self.components.zap = ZapperComponent(self)
	self.components.pyro = PyroComponent(self)
end

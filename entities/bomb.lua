--
-- bomb.lua
--

Bomb = Class{ type = "Bomb" }
Bomb:include(Entity)

function Bomb:init(world, x, y)
	self.world = world
	self.pos = vector(x, y)
	
	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.red, {16, 1})
	self.components.exploding = ExplodingComponent(self, 4, colors.red, colors.yellow)
end

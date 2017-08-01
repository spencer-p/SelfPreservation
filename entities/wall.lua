--
-- wall.lua
-- simple square obstacle
--

Wall = Class { type = "Wall" }
Wall:include(Entity)

function Wall:init(world, x, y)
	self.world = world
	self.pos = vector(x, y)

	self.components = {}
	self.components.graphics = GraphicsComponent(self, colors.bblack, {3, 12})
	self.components.physics = PhysicsComponent(self)
end

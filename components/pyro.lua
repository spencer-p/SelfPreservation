--
-- pyro.lua
-- gives entity ability to place bombs
--

PyroComponent = Class{}

function PyroComponent:init(parent)
	self.parent = parent
end

function PyroComponent:recieve(origin, message)
	if message.m == "bomb" then
		if origin == self.parent.world.player then
			self.parent.world:tick()
		end
		table.insert(self.parent.world.entities,
			Bomb(
				self.parent.world,
				message.location:unpack()
			)
		)
	end
end

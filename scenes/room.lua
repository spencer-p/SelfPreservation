-- 
-- room.lua
--

room = Class{}
room:include(AbstractScene)

function room:init()

	self.entityData = {
		{ name = "Turret", data = { 5, 1, "down" } },
		{ name = "Drone", data = { 7, 1 } },
		{ name = "Rockem", data = { 1, 1 } },
		{ name = "Bomb", data = { 5, 2 } }
	}

	self.backgroundColor = colors.black

	self.playerStartingPos = vector(5, 5)

	self.walls = {
		{
			start = vector(0, 0),
			delta = vector(0, 1),
			count = 7
		},
		{
			start = vector(10, 0),
			delta = vector(0, 1),
			count = 7
		},
		{
			start = vector(1, 0),
			delta = vector(1, 0),
			count = 9
		},
		{
			start = vector(1, 6),
			delta = vector(1, 0),
			count = 9
		}
	}

	self.nextScene = room5
end

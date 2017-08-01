
-- 
-- room5.lua
--

room5 = Class{}
room5:include(AbstractScene)

function room5:init()

	self.entityData = {
		{ name = "Turret", data = { 2, 1, "down" } },
		{ name = "Turret", data = { 2, 7, "up" } },
		{ name = "Turret", data = { 8, 1, "down" } },
		{ name = "Turret", data = { 8, 7, "up" } },
		{ name = "Drone", data = { 7, 1 } },
		{ name = "Drone", data = { 3, 7 } },
		{ name = "Rockem", data = { 1, 4 } },
		{ name = "Rockem", data = { 9, 4 } },
		{ name = "Rockem", data = { 3, 1 } },
		{ name = "Rockem", data = { 7, 7 } },
	}

	self.backgroundColor = colors.black

	self.playerStartingPos = vector(5, 4)

	self.walls = {
		{
			start = vector(0, 0),
			delta = vector(0, 1),
			count = 9
		},
		{
			start = vector(10, 0),
			delta = vector(0, 1),
			count = 9
		},
		{
			start = vector(1, 9),
			delta = vector(1, 0),
			count = 9
		},
		{
			start = vector(1, -1),
			delta = vector(1, 0),
			count = 9
		},
		{
			start = vector(2, 4),
			delta = vector(6, 0),
			count = 2
		},
	}

	self.nextScene = roomwin
end

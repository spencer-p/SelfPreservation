
-- 
-- room3 1
--

room3 = Class{}
room3:include(AbstractScene)

function room3:init()

	self.entityData = {
		{ name = "Turret", data = { 1, 1, "right" } },
		{ name = "Turret", data = { 3, 3, "left" } }
	}

	self.backgroundColor = colors.black

	self.playerStartingPos = vector(2, 5)

	self.walls = {
		{
			start = vector(0, 0),
			delta = vector(0, 1),
			count = 7
		},
		{
			start = vector(4, 0),
			delta = vector(0, 1),
			count = 7
		},
		{
			start = vector(1, 0),
			delta = vector(1, 0),
			count = 3
		},
		{
			start = vector(1, 6),
			delta = vector(1, 0),
			count = 3
		}
	}

	self.nextScene = room4
end

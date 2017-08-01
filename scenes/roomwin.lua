-- 
-- roomwin 1
--

roomwin = Class{}
roomwin:include(AbstractScene)

function roomwin:init()

	self.entityData = {
		{ name = "Turret", data = {1,2,"up"} },
		{ name = "Turret", data = {3,2,"up"} }
	}

	self.backgroundColor = colors.black

	self.playerStartingPos = vector(6, -2)

	self.walls = {
		{
			start = vector(0, 0),
			delta = vector(0, 1),
			count = 2
		},
		{
			start = vector(2, 0),
			delta = vector(0, 1),
			count = 2
		},
		{
			start = vector(4, 0),
			delta = vector(0, 1),
			count = 2
		},
		{
			start = vector(6, 0),
			delta = vector(0, 1),
			count = 3
		},
		{
			start = vector(8, 0),
			delta = vector(0, 1),
			count = 3
		},
		{
			start = vector(11, 1),
			delta = vector(0, 1),
			count = 2
		},
		{
			start = vector(9, 0),
			delta = vector(1, 0),
			count = 2
		}
	}

	self.nextScene = room1
end

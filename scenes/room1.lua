-- 
-- room1 1
--

room1 = Class{}
room1:include(AbstractScene)

function room1:init()

	self.entityData = {
		{ name = "Drone", data = { 5, 1 } }
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

	self.nextScene = room2
end

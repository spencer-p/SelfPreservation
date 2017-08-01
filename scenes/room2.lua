-- 
-- room2 1
--

room2 = Class{}
room2:include(AbstractScene)

function room2:init()

	self.entityData = {
		{ name = "Rockem", data = { 5, 1 } }
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

	self.nextScene = room3
end

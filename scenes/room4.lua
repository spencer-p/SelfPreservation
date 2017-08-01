--
-- room4.lua
--

room4 = Class{}
room4:include(AbstractScene)

function room4:init()

	self.entityData = {
		{ name = "Turret", data = { 1, 1, "right" } },
		{ name = "Turret", data = { 1, 3, "right" } },
		{ name = "Turret", data = { 1, 5, "right" } },
		{ name = "Turret", data = { 5, 2, "left" } },
		{ name = "Turret", data = { 5, 4, "left" } },
		{ name = "Turret", data = { 5, 6, "left" } },
		{ name = "Rockem", data = { 0, 0 } },
		{ name = "Rockem", data = { 6, 0 } },
		{ name = "Rockem", data = { 0, 7 } },
		{ name = "Rockem", data = { 6, 7 } },
	}

	self.backgroundColor = colors.black

	self.playerStartingPos = vector(3, 7)

	self.walls = {
		{
			start = vector(5, 1),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(5, 3),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(5, 5),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(1, 2),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(1, 4),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(1, 6),
			delta = FACINGS.none,
			count = 1
		},
		{
			start = vector(-1, -1),
			delta = FACINGS.up,
			count = 10
		},
		{
			start = vector(7, -1),
			delta = FACINGS.up,
			count = 10
		},
		{
			start = vector(0, -1),
			delta = FACINGS.left,
			count = 7
		},
		{
			start = vector(0, 8),
			delta = FACINGS.left,
			count = 7
		},
	}

	self.nextScene = room
end

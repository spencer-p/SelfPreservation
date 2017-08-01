--
--	spritesheet.lua
--	Abstracts the ascii sprites
--

Class = require "hump.class"

Spritesheet = Class{}

function Spritesheet:init(file)
	self.dim = { x = 16, y = 16 }
	self.size = { x = 16, y = 16 }
	self.sheet = love.graphics.newImage(file)
	self.sheet:setFilter("nearest", "nearest")
	self.quads = {}
	for i = 1, self.size.x do
		self.quads[i] = {}
		for j = 1, self.size.y do
			self.quads[i][j] = love.graphics.newQuad((i-1)*16, (j-1)*16, self.dim.x, self.dim.y, self.sheet:getDimensions())
		end
	end
end

function Spritesheet:getQuad(x, y)
	return self.quads[x][y]
end

function Spritesheet:getImg()
	return self.sheet
end

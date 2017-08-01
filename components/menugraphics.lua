--[[
	menugraphics.lua
	Component for the menus cuz menus are entities?
]]

Class = require "hump.class"

MenuGraphicsComponent = Class{}

-- Requires parent, color for unselected item, color for selected item
function MenuGraphicsComponent:init(parent, color1, color2)
	self.parent = parent
	self.colors = {}
	self.colors.unselected = color1
	self.colors.selected = color2
	self.textHeight = 16 -- fuck if i know
end

function MenuGraphicsComponent:draw()
	-- Draw the title
	love.graphics.setColor(self.colors.selected)
	love.graphics.printf(self.parent.title, 0, love.graphics.getHeight()/(4*SCALE), love.graphics.getWidth()/SCALE, 'center')

	-- Draw the options, properly colored
	for i = 1, #self.parent.options do
		if i == self.parent.selected then
			love.graphics.setColor(self.colors.selected)
		else
			love.graphics.setColor(self.colors.unselected)
		end
		love.graphics.printf(self.parent.options[i], 0, love.graphics.getHeight()/(4*SCALE) + (i+1)*self.textHeight, love.graphics.getWidth()/SCALE, 'center')
	end
end

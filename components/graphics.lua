--
-- graphics component
-- displays an image from the tileset with whatever color
--

Class = require "hump.class"

GraphicsComponent = Class{}

-- Requires the parent, then the color, then sprite index
function GraphicsComponent:init(parent, c, i)
	self.parent = parent
	self.sprite = SPRITES:getQuad(i[1], i[2])
	self.color = c

	self.facingColor = colors.base04
	self.facingAlpha = 0
	self:tweenFacingAlpha()
end

function GraphicsComponent:draw()
	-- draw entity
	love.graphics.setColor(self.color)
	love.graphics.draw(SPRITES:getImg(), self.sprite, 16*self.parent.pos.x, 16*self.parent.pos.y)
end

function GraphicsComponent:drawUnder()
	-- First draw facing
	if self.parent.facing ~= nil then
		love.graphics.setColor(self.facingColor[1], self.facingColor[2], self.facingColor[3], self.facingAlpha)
		love.graphics.draw(SPRITES:getImg(), 
			SPRITES:getQuad(16,11),
			16*self.parent.pos.x + 8,
			16*self.parent.pos.y + 8,
			self.parent.facing:angleTo(vector(-1, 0)),
			2, 2, 8, 8)
	end
end

function GraphicsComponent:tweenFacingAlpha()
	local targetAlpha
	if self.facingAlpha > 0x80 then 
		targetAlpha = 0
	else 
		targetAlpha = 0xff
	end

	Timer.tween(2, self, { facingAlpha = targetAlpha }, 'in-out-sine', function() self:tweenFacingAlpha() end)
end

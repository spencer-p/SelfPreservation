--
-- turret.lua
-- pew pew
--

TurretComponent = Class{}

function TurretComponent:init(parent)
	self.parent = parent
	self.bullet = nil
	self.dir = self.parent.facing
end

function TurretComponent:draw()
	if self.bullet then
		love.graphics.setColor(colors.magenta)
		love.graphics.draw(
			SPRITES:getImg(),
			SPRITES:getQuad(14, 3),
			16*self.bullet.x+8,
			16*self.bullet.y+8,
			self.dir:angleTo(),
			1, 1, 8, 8
		)
	end
end

function TurretComponent:update(dt)
	if self.bullet and not self.checked then
		-- check if it hit anybody
		local entity = self.parent.world:entityAt(self.bullet)
		if entity then
			entity:send(self.parent, { m = "damage", damage = 2 })
			self.bullet = nil
		end
		self.checked = true
	end
end

function TurretComponent:tick()
	if not self.bullet then
		-- Create the bullet
		self.bullet = self.parent.pos - self.dir
	else
		-- Move the bullet
		self.bullet = self.bullet - self.dir
	end
	self.checked = false
end

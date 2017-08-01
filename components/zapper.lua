--
-- zapper.lua
-- zaps an enemy for extra health
--

ZapperComponent = Class{}

function ZapperComponent:init(parent, maxdmg)
	self.parent = parent
	self.maxdmg = maxdmg
end

function ZapperComponent:update(dt)
	if self.zapOnUpdate then
		self:zap()
		self.zapOnUpdate = false
	end
end

function ZapperComponent:recieve(origin, message)
	if message.m == "zap" then
		if origin == self.parent.world.player then
			self:zap()
		else
			self.zapOnUpdate = true
		end
	end
end

function ZapperComponent:zap()
	entity = self.parent.world:entityAt(self.parent.pos - self.parent.facing)
	if entity and entity.components and entity.components.health then
		local damage = self.maxdmg or entity.components.health.hp
		entity:send(self.parent, { m = "damage", damage = damage })
		self.parent:send(self.parent, { m = "heal", amount = damage })
	end
end

--
-- components.entity.lua
-- Mixin for sending messages.
-- Implements callbacks that find the callbacks
-- within the entity's components and call them.
-- Also includes a send function that repeats messages
-- for ECS.
--

Class = require "hump.class"

Entity = Class{ type = "Entity" }

function Entity:callInTable(t, fname, ...)
	if fname == "send" then print(fname, t) end
	for i, val in pairs(t) do
		if val[fname] then
			val[fname](val, unpack({...}))
		end
	end
end

function Entity:generateCallback(fname)
	return function(self, ...)
		self:callInTable(self.components, fname, ...)
	end
end

local callbacks = { 
	{ "draw", "draw" },
	{ "drawUnder", "drawUnder" },
	{ "tick", "tick" },
	{ "send", "recieve" },
	{ "update", "update" },
	{ "keypressed", "keypressed" },
	{ "keyreleased", "keyreleased" },
	{ "joystickpressed", "joystickpressed" },
	{ "joystickreleased", "joystickreleased" },
	{ "joystickaxis", "joystickaxis" }
}

for i, fnames in ipairs(callbacks) do
	Entity[fnames[1]] = Entity:generateCallback(fnames[2])
end

-- Utility methods for entities
function Entity:generateDamageMessage()
	return {
		m = "damage",
		damage = self.damage or 1,
		from = self.parent
	}
end

function Entity:generateCollisionMessage(entity)
	return {
		m = "collision",
		e = entity,
		o = self.parent
	}
end

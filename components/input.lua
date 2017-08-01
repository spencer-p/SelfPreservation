--[[
	components.input.lua
	Component for user input for player character
]]

Class = require "hump.class"
vector = require "hump.vector"

InputComponent = Class{
	directions = {
		w = vector(0, -1),
		a = vector(-1, 0),
		s = vector(0, 1),
		d = vector(1, 0)
	}
}

function InputComponent:init(parent)
	self.parent = parent
end

-- Key press/release

function InputComponent:keypressed(key)
	if key == 'w' or key == 'a' or key == 's' or key == 'd' then
		if love.keyboard.isDown("lshift") then
			self.parent:send(self.parent, { m = "bomb", location = self.parent.pos + self.directions[key] })
		else
			self.parent:send(self.parent, { m = "move", vector = self.directions[key] })
		end
	elseif key == '.' then
		self.parent.world:tick()
	end
end

function InputComponent:keyreleased(key)
end

-- Joystick press/release

----function InputComponent:joystickpressed(joystick, button)
----	if button == 2 then
----		self.parent:send(self, { m = "attack" })
----	end
----end

----function InputComponent:joystickaxis(joystick, axis, value)
----	if axis == 1 then
----		if value == 1 then
----			self.velStack[#self.velStack+1] = 'd'
----		elseif value == -1 then
----			self.velStack[#self.velStack+1] = 'a'
----		elseif value == 0 then
----			for i, n in ipairs(self.velStack) do
----				if n == 'd' or n == 'a' then
----					table.remove(self.velStack, i)
----				end
----			end
----		end
----	elseif axis == 2 then
----		if value == 1 then
----			self.velStack[#self.velStack+1] = 's'
----		elseif value == -1 then
----			self.velStack[#self.velStack+1] = 'w'
----		elseif value == 0 then
----			for i, n in ipairs(self.velStack) do
----				if n == 's' or n == 'w' then
----					table.remove(self.velStack, i)
----				end
----			end
----		end
----	end
----end

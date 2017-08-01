--
-- abstractscene.lua
-- Abstract Scene class for scenes
--
-- This hijacks a few of the callbacks.
--

AbstractScene = Class{}

function AbstractScene:enter(previous, player)
	self.entities = {}

	-- Set bg color
	love.graphics.setBackgroundColor(self.backgroundColor)

	-- Add entities according to data
	for i, entry in ipairs(self.entityData) do
		table.insert(self.entities, _G[entry.name](self, unpack(entry.data)))
	end

	-- Reset / add player
	self.player = player
	self.player:init(self, self.playerStartingPos:unpack())
	table.insert(self.entities, player)

	-- Add walls (after player for layering)
	self:addWalls(self.entities, self.walls)

	-- Set up camera
	local look = 16*self.player.pos + vector(8, 8)
	self.camera = Camera(look.x, look.y, SCALE/16)
	Timer.tween(1, self.camera, { scale = SCALE }, 'out-quad')
	SOUNDS.enter:play()
end

function AbstractScene:resume(prev, player)
	self.player = player
end

function AbstractScene:draw()
	self.camera:attach()
	self:callInTable(self.entities, "drawUnder")
	self:callInTable(self.entities, "draw")
	self.camera:detach()
end

function AbstractScene:update(dt)
	self:callInTable(self.entities, "update", dt)

	if not self.cameraDelta then self.cameraDelta = 0 end
	self.cameraDelta = self.cameraDelta + dt
	if self.cameraDelta > 1/60 then
		local deltaLook = 16*self.player.pos + vector(8, 8)
			- vector(self.camera.x, self.camera.y)
		self.camera:move((deltaLook/4):unpack())
		self.cameraDelta = 0
	end

	-- TODO handle player death
	if self:pruneDead(self.entities, self.player) == -1 then
		Gamestate.switch(Gamestate.current(), self.player)
	end

	if self:noMonstersLeft() then
		SOUNDS.complete:play()
		if self.nextScene then
			Gamestate.switch(self.nextScene, self.player)
		else
			print "Congrats, you win!"
			love.event.quit()
		end
	end
end

function AbstractScene:tick()
	self.player:send(nil, { m = "damage", damage = 1 })
	self:callInTable(self.entities, "tick")
end

function AbstractScene:callInTable(t, fname, ...)
	for i, val in ipairs(t) do
		if val[fname] then
			val[fname](val, unpack({...}))
		end
	end
end

function AbstractScene:noMonstersLeft()
	for i, e in ipairs(self.entities) do
		if e.type == "Rockem" or e.type == "Drone" or e.type == "Turret" then
			return false
		end
	end
	return true
end

-- Returns:
-- -1 if player is dead
-- n if player killed n
function AbstractScene:pruneDead(t, player)
	local playerIsDead = false
	local playerKillCount = 0
	for i, e in ipairs(t) do
		if e.dead then
			if e == player then
				playerIsDead = true
			elseif e.killedByPlayer then
				playerKillCount = playerKillCount + 1
			end
			table.remove(t, i)
		end
	end
	if playerIsDead then
		return -1
	else
		return playerKillCount
	end
end

function AbstractScene:addWalls(t, wallData)
	for _, wallSet in ipairs(wallData) do
		for i = 0, wallSet.count - 1 do
			table.insert(t, Wall(self, (wallSet.start + i * wallSet.delta):unpack()))
		end
	end
end

function AbstractScene:entityAt(vectorOrX, y)
	-- Get args
	local position
	if type(vecotOrX) == "number" then
		position = vector(vectorOrX, y)
	else
		position = vectorOrX
	end

	-- Loop through entities
	for _, e in ipairs(self.entities) do
		if e.pos and e.pos == position then
			return e
		end
	end
end

function AbstractScene:keypressed(key)
	self.player:keypressed(key)
end

function AbstractScene:keyreleased(key)
	if key == "escape" then love.event.quit() end
	self.player:keyreleased(key)
end

function AbstractScene:joystickpressed(j, button)
	self.player:joystickpressed(j, button)
end

function AbstractScene:joystickreleased(j, button)
	self.player:joystickreleased(j, button)
end

function AbstractScene:joystickaxis(j, axis, value)
	self.player:joystickaxis(j, axis, value)
end

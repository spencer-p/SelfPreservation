-- 
-- main.lua
--

-- Import HUMP
Gamestate = require "hump.gamestate"
Class = require "hump.class"
Camera = require "hump.camera"
Timer = require "hump.timer"
vector = require "hump.vector"

-- Utils, etc
require "util.spritesheet"
require "util.colors"

-- Gamestates
require "scenes.abstractscene"
require "scenes.title"
require "scenes.room"
require "scenes.room1"
require "scenes.room2"
require "scenes.room3"
require "scenes.room4"
require "scenes.room5"
require "scenes.roomwin"

-- Entity components
require "components.entity"
require "components.menugraphics"
require "components.menuphysics"
require "components.graphics"
require "components.exploding"
require "components.physics"
require "components.input"
require "components.health"
require "components.zapper"
require "components.pyro"
require "components.droneai"
require "components.rockemai"
require "components.turret"

-- Entities
require "entities.player"
require "entities.turret"
require "entities.drone"
require "entities.rockem"
require "entities.bomb"
require "entities.wall"

-- Global variables
SCALE = 4
SPRITES = Spritesheet("Md_curses_16x16.png")
PLAYER = Player(nil, 0, 0)
SOUNDS = {
	hit = love.audio.newSource("sounds/hit.wav", "static"),
	complete = love.audio.newSource("sounds/complete.wav", "static"),
	explode = love.audio.newSource("sounds/explode.wav", "static"),
	enter = love.audio.newSource("sounds/enter.wav", "static"),
}
FACINGS = {
	up = vector(0, 1),
	down = vector(0, -1),
	left = vector(1, 0),
	right = vector(-1, 0),
	none = vector(0, 0)
}

function love.load()

	-- Seed random
	math.randomseed(os.time())

	-- bg
	love.graphics.setBackgroundColor(colors.black)
	
	-- Start gamestates
	Gamestate.registerEvents()
	Gamestate.switch(titlescreen, PLAYER)
end

function love.update(dt)
	Timer.update(dt)
	-- Lovebird web debugging
	lovebird = require "lovebird.lovebird"
	lovebird.update(dt)
end

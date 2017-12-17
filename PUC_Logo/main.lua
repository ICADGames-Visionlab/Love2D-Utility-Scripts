require "PUC_Logo"

local game = {}
local logo = PUC_Logo
local current_step

function love.load()
  logo.load(1,1,1,1,love.startGame)
  current_step = logo
end

function love.update(dt)
  current_step.update(dt)
end

function love.draw()
  current_step.draw()
end

function love.keypressed(key)
  current_step.keypressed(key)
end

function game.update(dt)
end

function game.draw()
  local w = love.graphics.getWidth()
  local h = love.graphics.getHeight()
  love.graphics.setColor(255,0,0)
  love.graphics.rectangle("fill", w/4, h/4, w/2, h/2)
  love.graphics.setColor(255,255,255)
end

function game.keypressed(key)
end

function love.startGame()
  current_step = game
end
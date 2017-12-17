require "parallax"

local parallaxBackground

function love.load()
  local screenWidth = love.graphics.getWidth()
  local screenHeight = love.graphics.getHeight()
  local planoDeep = {
    image = love.graphics.newImage("planoDeep.png"),
    speed = screenWidth/5,
    width = screenWidth,
    height = screenHeight
  }
  local planoBackground = {
    image = love.graphics.newImage("planoBackground.png"),
    speed = screenWidth/2,
    width = screenWidth,
    height = screenHeight
  }
  local mapsVector = {planoDeep, planoBackground}
  parallaxBackground = parallax_new(mapsVector)
end

function love.update(dt)
  parallax_update(dt,parallaxBackground)
end

function love.draw()
  parallax_draw(parallaxBackground)
end
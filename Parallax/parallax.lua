

--[[ 

Requires vector of maps V with each map having:
  - image: The image of the plane
  - speed: Speed of the moving map (tiles per second)
  - width: Width desirable for the map, in points
  - height: Width desirable for the map, in points

The order is important, the deepest maps first
  
  example code:
  
  (GLOBAL)
  local parallaxBackground
  
  (LOAD)
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
  
  (UPDATE)
  -- IF YOU WANT TO MOVE WITH THE DEFAULT SPEED, DOESN NOT NEED THE PARAMETER mov
  parallax_update(dt, parallaxBackground)
  -- MOV is to change somehow the SPEED, for example, make the parallax move 50% slower -> mov = 0.5
  parallax_update(dt, p, 0.5)
  
  (DRAW)
  parallax_draw(parallaxBackground)
]]

local updateWithVel

function parallax_new(listOfMaps)
  for i,v in ipairs(listOfMaps) do
    v.position = 0
    v.scale = {
      x = v.width / v.image:getWidth(),
      y = v.height / v.image:getHeight()
    }
  end
  return {list = listOfMaps}
end

function parallax_update(dt, p, mov)
  if mov == nil then mov = 1 end
  for i,v in ipairs(p.list) do
    v.position = v.position + v.speed*mov*dt
    if v.position > v.width then
      v.position = v.position%v.width
    end
  end
end

function parallax_draw(p)
  for i,v in ipairs(p.list) do
    local pos = v.position
    love.graphics.draw(v.image, -pos, 0, 0, v.scale.x, v.scale.y)
    love.graphics.draw(v.image, v.width-pos, 0, 0, v.scale.x, v.scale.y)
  end
end
--[[
PUC Logo animation (based on 1280x720)
Load with the time for each animation and an optional callback:
 - t1: logo fadeIn time
 - t2: logo movement time
 - t3: title fadeIn time
 - t4: fadeOut time
 - callback: a function to be called when logo presentation is over
 
 This script calls the callback when the animation ends or when the ENTER key is pressed
 To know when it is finished from other script you can access PUC_Logo.finish
 ]]
 
PUC_Logo={}
local logoDist = 0.9
local letterDist = 0.03
local fadeMax = 240
local endLogo

function PUC_Logo.load(t1,t2,t3,t4,callback)
  PUC_Logo.logo=love.graphics.newImage("/logo.png")
  PUC_Logo.logoWidth=PUC_Logo.logo:getWidth()
  PUC_Logo.logoHeight=PUC_Logo.logo:getHeight()
  PUC_Logo.logoX=love.graphics.getWidth()/2
  PUC_Logo.logoY=2*love.graphics.getHeight()/5
  
  PUC_Logo.posx=logoDist*love.graphics.getWidth()-PUC_Logo.logoWidth/2
  PUC_Logo.vel=(PUC_Logo.posx-PUC_Logo.logoX)/t2
  PUC_Logo.fvel1=fadeMax/t1
  PUC_Logo.fvel3=fadeMax/(0.7*t3)
  PUC_Logo.fvel4=fadeMax/t4
  
  PUC_Logo.logoLetter=love.graphics.newImage("/letter.png")
  PUC_Logo.logoLetterWidth=(logoDist-letterDist)*love.graphics.getWidth() - PUC_Logo.logoWidth
  PUC_Logo.logoLetterHeight=PUC_Logo.logoLetter:getHeight()
  PUC_Logo.logoLetterX=((logoDist+letterDist)*love.graphics.getWidth()-PUC_Logo.logoWidth)/2
  PUC_Logo.logoLetterY=2*love.graphics.getHeight()/5
  PUC_Logo.logoLetterfWidth=PUC_Logo.logoLetterWidth/PUC_Logo.logoLetter:getWidth()
  
  PUC_Logo.a1=t1
  PUC_Logo.a2=t2
  PUC_Logo.a3=t3
  PUC_Logo.a4=t4
  PUC_Logo.fade1=0
  PUC_Logo.fade3=0
  PUC_Logo.fadeOut = fadeMax
  PUC_Logo.finish=false
  PUC_Logo.callback = callback
end

function PUC_Logo.start()
end

function PUC_Logo.update(dt)
  
  if PUC_Logo.a4>0 then
    if PUC_Logo.a3>0 then
      if PUC_Logo.a2>0 then
        if PUC_Logo.a1>0 then
          PUC_Logo.a1 = PUC_Logo.a1 - dt
          PUC_Logo.fade1 = PUC_Logo.fade1 + PUC_Logo.fvel1 * dt
        else
          PUC_Logo.a2 = PUC_Logo.a2 - dt
          PUC_Logo.logoX = PUC_Logo.logoX + PUC_Logo.vel * dt
        end
      else
        PUC_Logo.a3 = PUC_Logo.a3 - dt
        if PUC_Logo.fade3<fadeMax then
          PUC_Logo.fade3 = PUC_Logo.fade3 + PUC_Logo.fvel3 * dt
        end
      end
    else
      PUC_Logo.a4 = PUC_Logo.a4 - dt
      PUC_Logo.fadeOut = PUC_Logo.fadeOut - PUC_Logo.fvel4*dt
    end
  else
    endLogo()
  end
end

function PUC_Logo.draw()
  local a,b
  if PUC_Logo.a3<=0 then
    a=PUC_Logo.fadeOut
    b=PUC_Logo.fadeOut
  else
    a=PUC_Logo.fade3
    b=PUC_Logo.fade1
  end
  --if PUC_Logo.a3>0 and PUC_Logo.a2<=0 then
      love.graphics.setColor(255,255,255,a)
      love.graphics.draw(PUC_Logo.logoLetter,PUC_Logo.logoLetterX,PUC_Logo.logoLetterY,0,PUC_Logo.logoLetterfWidth,1,PUC_Logo.logoLetter:getWidth()/2,PUC_Logo.logoLetterHeight/2)
  --end
  love.graphics.setColor(255,255,255,b)
  love.graphics.draw(PUC_Logo.logo,PUC_Logo.logoX,PUC_Logo.logoY,0,1,1,PUC_Logo.logoWidth/2,PUC_Logo.logoHeight/2)
  love.graphics.setColor(255,255,255)
end

function PUC_Logo.keypressed(key)
  if key=="return" then
    endLogo()
  end
end

function endLogo()
  PUC_Logo.finish = true
  if PUC_Logo.callback ~= nil then
	PUC_Logo.callback()
	end
end
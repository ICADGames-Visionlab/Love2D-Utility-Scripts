require "quadrangle"

Rectangle = class_extends(Quadrangle,"Rectangle")

function Rectangle.new(x,y,width,height)
  return Rectangle.newObject(x,y,width,height,0,math.pi/2)--Rectangle:superClass().new(x,y,width,height)
end

function Rectangle:print()
  print(self:name() .. "{")
  print("\tx = " .. self.x)
  print("\ty = " .. self.y)
  print("\twidth = " .. self.width)
  print("\theight = " .. self.height .."\n}")
end
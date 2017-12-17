require "class"

Quadrangle = class_new("Quadrangle")

function Quadrangle.new(x,y,width,height,widthAngle, heightAngle)
  local self = Quadrangle.newObject()
  self.x=x
  self.y=y
  self.width=width
  self.height=height
  self.widthAngle=widthAngle
  self.heightAngle=heightAngle
  return self
end

function Quadrangle:print()
  print(self:name() .. "{")
  print("\tx = " .. self.x)
  print("\ty = " .. self.y)
  print("\twidth = " .. self.width)
  print("\theight = " .. self.height)
  print("\twidthAngle = " .. self.width)
  print("\theightAngle = " .. self.height .."\n}")
end
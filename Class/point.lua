require "class"

Point = class_new("Point")

function Point.new(x,y)
  local self = Point.newObject()
  self.x=x
  self.y=y
  return self
end

function Point:print()
  print(self:name() .. "{")
  print("\tx = " .. self.x)
  print("\ty = " .. self.y .."\n}")
end
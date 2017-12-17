require "square"
require "point"

io.stdout:setvbuf("no")

local testClass, testClasses

function testClasses()
  testClass(Square, 20, 30, 400)
  testClass(Rectangle, 40, 50, 200,300)
  testClass(Quadrangle, 60, 70, 100,250,math.pi/4,math.pi*3/4)
  testClass(Point,5,500)
end

function testClass(someClass, ...)
  local n = someClass.new(...)
  print("is " .. Square:name() .. ": " .. tostring(n:is_a(Square)))
  print("is " .. Rectangle:name() .. ": " .. tostring(n:is_a(Rectangle)))
  print("is " .. Quadrangle:name() .. ": " .. tostring(n:is_a(Quadrangle)))
  print("is " .. Point:name() .. ": " .. tostring(n:is_a(Point)))
  n:print()
  print()
end

testClasses()
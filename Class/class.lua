--[[
Script to simulate class and inheritance in Lua
How to use:

*Initialize a base class using:
  myClass = class_new("myClassName")
When creating a new instance, you need to first initialize it with:
  local self = myClass.newObject()
If you pretend to subClass the class, implement the instance creation method as .new
Then you can set your properties

*Initialize a subclass (of myClass):
  subClass = class_extends(myClass,"subClassName")
When creating a new instance, you need to first initialize it:
  local self = subClass.newObject(PASS HERE THE PARAMETERS OF THE SUPERCLASS INIT)

*Availables methods for an instance of a class created with a script
  :class() - Returns the class of the instance
  :name() - Returns the name of the instance's class, or "unknown" if no name was given
  :superClass() - Returns the superClass of the instance's class, or NIL if it doesn't have one
  :superClasses() - Returns an array with all the superClassses
  :is_a(class) - Checks if the instance is of the given class, or a subclass of it
  
*Example

myClass = class_new("myClassName")
function myClass.new(a,b,c)
  local self = myClass.newObject()
  self.a = a
  self.b = b
  self.c = c
end

subClass = class_extends(myClass,"myClassName")
function subClass.new(a)
  local self = subClass.new(a,a*2,a*3)
  return self
end
]]

function class_new(name)
  local new_class = {}
  new_class.__index = new_class
  function new_class.newObject(...)
    local sup = new_class:superClass()
    local newinst = sup == nil and {} or sup.new(...)
    --local newinst = {}
    setmetatable(newinst, new_class)
    return newinst
  end
  new_class.new = new_class.newObject
  
  function new_class:class()
    return new_class
  end
  function new_class:name()
    return (name == nil and "unknown" or name)
  end
  function new_class:superClass()
    return nil
  end
  function new_class:superClasses()
    local classes = {}
    local curr_class = new_class:superClass()
    while curr_class ~= nil do
      table.insert(classes,curr_class)
      curr_class = curr_class:superClass()
    end
    return classes
  end
  
  function new_class:is_a(someClass)
    local cur_class = new_class
    while cur_class ~= nil do
      if cur_class == someClass then return true
      else cur_class = cur_class:superClass() end
    end
    return false
  end
  
  return new_class
end

function class_extends(baseClass,name)
  local new_class = class_new(name)
  if baseClass~=nil then 
    setmetatable(new_class,baseClass)
    function new_class:superClass()
      return baseClass
    end
  end
  return new_class
end
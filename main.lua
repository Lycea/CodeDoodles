require("imgui")
require("helpers")
require("module_finder")

require("doodle_template.main")
local modules = {}


--indexes for showen modules, 1 is default 
local actual_index = 1


local dummy = {}


function dummy.draw()
  
end

function dummy.update(dt)
  
  
end


function love.load(args)
  --require("mobdebug").start()
  --load all available 
  local files =start(arg[1])
  local i = true
  local co = 1
  
   for i=1, #files do
       --print(files[i].name) 
       if files[i].has_child then
         -- print(#files[i].child)
          --require the modules
         -- modules[#modules+1]=require(files[i].name..".main")
       end
       --print("added module")
   end
end


function love.update(dt)
  
end

function love.draw()
end

require("imgui")
helper = require("helpers")
require("module_finder")

require("doodle_template.main")
local modules = {}


--indexes for showen modules, 1 is default 
local actual_index = 1


local dummy = {}
local circles ={}
local main_canv = love.graphics.newCanvas(love.graphics.getHeight(),love.graphics.getWidth())
local time = 0

dist_to_par= 30
function dummy.draw()
  love.graphics.setCanvas(main_canv)
  
  --for _=1 ,#circles do
  --  love.graphics.setColor(helper.colors.pico8[circles[_].color])
  --  love.graphics.circle("fill",circles[_].x,circles[_].y,circles[_].size+1,100)
  --end
  love.graphics.setColor(255,255,255,255)

  
  --main circle
  love.graphics.circle("fill",70,70,4)
  
  --orbiting cirle
  planet ={}
  planet.x =dist_to_par*math.sin(time) + 70
  planet.y =dist_to_par*math.cos(time) + 70
  love.graphics.circle("fill",planet.x,planet.y,2)
  print(helper.dist({x=70,y=70},{x=planet.x,y=planet.y}))
  
  --moon
  love.graphics.circle("fill", dist_to_par/2 *math.sin(time*2) + planet.x,dist_to_par/2 *math.cos(time*2)+planet.y,1)
  
  
  love.graphics.setCanvas()
  
  love.graphics.setColor(255,255,255,255)
  love.graphics.draw(main_canv,0,0)
  
  love.graphics.setColor(0,0,0,255)
  
  
--   magic pixel effects :)
   data =main_canv:newImageData()
   love.graphics.setCanvas(main_canv)
  for i=0,500 do
      local x= math.random(1,599)
      local y= math.random(1,599)
      local size= math.random(5,10)
      --print(x.." "..y)
      r,g,b= data:getPixel(x,y)
      
      if r+g+b ~= 3*255 then
        love.graphics.circle("fill",x,y,10)
      else
        i=i-1
      end
  end
    love.graphics.line(0,0,600,0)
    love.graphics.line(0,0,0,600)
  love.graphics.setCanvas()
end




function dummy.update(dt)
  time = time+dt
  while #circles < 20 do
    circles[#circles+1] = {}
    circles[#circles].x     = math.random(10,600)
    circles[#circles].y     = math.random(10,600)
    circles[#circles].size  = math.random(10,15)
    circles[#circles].off   = math.random(0,(math.pi)*1000)
    circles[#circles].color = math.random(7,#helper.colors.pico8)
    print(circles[#circles].off)
  end
  
  for _=1,#circles do
    circles[_].size = math.sin(time*0.7+circles[_].off)+circles[_].size
  end
end


function love.load(args)
  --require("mobdebug").start()
  --load all available 
  local files =start(arg[1])
  local i = true
  local co = 1
  
  modules[1] = dummy
   for i=1, #files do
       --print(files[i].name) 
       if files[i].has_child then
         -- print(#files[i].child)
          --require the modules
         --modules[#modules+1]=require(files[i].name..".main")
       end
       --print("added module")
   end
end


function love.update(dt)
  modules[actual_index].update(dt)
end

function love.draw()
  modules[actual_index].draw(dt)
end




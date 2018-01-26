local screen_width, screen_height = love.graphics.getWidth(),love.graphics.getHeight()
local circles = {}
local num_of_circles = 15

love.graphics.setLineStyle('rough')



function Clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end


local palette =
{
  {0,0,0},
  {29,43,83},
  {126,37,83},
  {0,135,81},
  {171,82,54},
  {95,87,79},
  {194,195,199},
  {255,241,232},
  {255,0,77},
  {255,163,0},
  {255,236,39},
  {0,228,54},
  {41,173,255},
  {131,11,156},
  {255,119,168},
  {255,204,170}
}


local color_lookup = { }



local dark =
{
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  1,
  3,
  5,
  5,
  4,
  2,
  3,
  3,
  5
  
}

local dark2=
{
  0,1,1,2,1,5,6,2,4,9,3,1,1,2,5
}

local rainbow = 
{
  1,1,1,1,1,1,1,1,1,9,10,11,12,13,14,1
}


local rainbow_bw = 
{
  1,1,1,1,1,1,1,1,10,11,12,13,14,15,16,1
}

local fire={
  [11]=10,
  [10]=9,
  [9]=3,
  [8]=1,
  [7]=1,
  [6]=1,
  [5]=1,
  [3]=2,
  [4]=1,
  [2]=1,
  [1]=1,
  [0]=0}

local function lerp_(x,y,t) local num = x+t*(y-x)return num end

local function lerp_point(x1,y1,x2,y2,t)
  local x = lerp_(x1,x2,t)
  local y = lerp_(y1,y2,t)
  --print(x.." "..y)
  return x,y
end


local function dist(p1,p2) return ((p2.x-p1.x)^2+(p2.y-p1.y)^2)^0.5 end




function create_circle()
  local tmp =       
  {
      x = math.random(5,screen_width-1),
      y= math.random(5,screen_height-1),
      size = math.random(1,5),
      color = 10--math.random(8,#palette-2)
   }
  return tmp
end


function create_lookup()
 for key,tab in ipairs(palette) do
   
     if color_lookup[tab[1]] == nil then
       color_lookup[tab[1]] = {}
     end
     if color_lookup[tab[1]][tab[2]] == nil then
       color_lookup[tab[1]][tab[2]] = {}
     end
     if color_lookup[tab[1]][tab[2]][tab[3]] == nil then
       color_lookup[tab[1]][tab[2]][tab[3]]  = {}
     end
     color_lookup[tab[1]][tab[2]][tab[3]]  = key
 end
end





function BEGIN_DRAW()
  love.graphics.setCanvas(canvas)
  love.graphics.setLineWidth(3)
  local data = canvas:newImageData()
  for i = 1, 3000 do
    local x,y=math.random(0,screen_width-1),math.random(0,screen_height-1)
    -- If we want to do something based on the color at the pixel x,y
    local r,g,b=data:getPixel(x,y)
    -- if math.random(1000) > 600 then
      --    print(color_lookup[r][g][b])
         love.graphics.setColor(palette[fire[color_lookup[r][g][b]]])
    -- else
     -- love.graphics.setColor(r,g,b)
     --end
      
    -- the dithering effect
    local avg = (r+g+b)
    if avg > 0 or math.random(0,200)>150 then
      local offs = 0
      love.graphics.line(x+5,y+offs,x-5,y+offs)
      love.graphics.line(x,y+5+offs,x,y-5+offs)
     -- love.graphics.circle("fill",x,y-10,7,100)
    else
      
    end
    
  end
  love.graphics.setLineWidth(2)
end

function END_DRAW()
  
  love.graphics.setCanvas()
  love.graphics.setColor (255,255,255)
  love.graphics.setBlendMode('alpha', 'premultiplied')
 -- shack:apply()
  love.graphics.draw(canvas,0,0,0,1,1)
end

function color(i)
  love.graphics.setColor(palette[i+1])
end
col = 11



function bitand(a, b)
    local result = 0
    local bitval = 1
    while a > 0 and b > 0 do
      if a % 2 == 1 and b % 2 == 1 then -- test the rightmost bits
          result = result + bitval      -- set the current bit
      end
      bitval = bitval * 2 -- shift left
      a = math.floor(a/2) -- shift right
      b = math.floor(b/2)
    end
    return result
end


local time_old = 0
function dark_col(i)
    love.graphics.setColor(palette[dark[i]])
end


max = 500
multi = 255
function r(i,j)
  --return i*j%multi
  return i*j%dist({x=0,y=0},{x=i,y=j})
  --return dist({x=i,y=j},{x=max/2,y=max/2})+math.sin(i/j)*multi
end


function g(i,j)
  --return i*j%multi
  return i*j%dist({x=max/2,y=max/2},{x=i,y=j})
  --return dist({x=i,y=j},{x=max/2,y=max/2})+math.cos(i/j)*multi
end


function b(i,j)
  --return i*j%multi
  return i*j%dist({x=max,y=max},{x=i,y=j})
  --return dist({x=i,y=j},{x=max/2,y=max/2})+math.tan(i/j)*multi
end


count = 0


local canv = love.graphics.newCanvas(max, max)
canv:setFilter('nearest','nearest')


function love.update(dt)
  
  --if count == 0 then
    img = nil
    img = {}
    

    count = count +1
  --end
 -- multi = multi + 1
 imgui.NewFrame()
end


--arguments shader 3
x_1,x_2 = 10,10
y_1,y_2 = 10,10

--arguments shader 4:p
point_r = {0,0}
point_g = {0.5,0.5}
point_b = {1.0,1.0}

txt_fi = ""


shdr_idx = 3
local shaders={}



local line_buff = {}
line_buff[1]=""
local LINE_BUFF_MAX = 70
local actual_line = 1
local actual_pos = 1

function love.load()
  imgui = require("imgui")
    require("mobdebug").start()
     
     shaders_code =
     {
         --lines_verti/hori =
         [[
          vec4 effect( vec4 color, Image texture, vec2 coo, vec2 screen_coords )
          {
            float r = sin(coo.x/2*100);//coo.x;
            float g = sin(coo.y/2*100);    //coo.y;
            float b = sin((coo.x+coo.y)/2*100);
            
            return vec4(r,g,b,1)*color;
          }
        ]]
      ,
      -- lines_color=
     [[
         uniform float multi_x[2];
         uniform float multi_y[2];
         
         
        vec4 effect( vec4 color, Image texture, vec2 coo, vec2 screen_coords )
        {
          float r = pow(coo.x,coo.y);//coo.x;
          float g = mod(coo.y*multi_y[0],coo.x*multi_x[0]);    //coo.y;
          float b = mod(coo.x*multi_x[1],coo.y*multi_y[1]);
          
          return vec4(r,g,b,1);
        }
      ]]
      ,
      [[  
        vec4 effect( vec4 color, Image texture, vec2 coo, vec2 screen_coords )
        {
          
          float r = (coo.x*coo.y)*10;
          float g = coo.y*2;
          float b = coo.x*2;
          
          return vec4(r,g,b,1);
        }
      ]]
      ,
      [[  
        uniform vec2  pointr;
        uniform vec2  pointg;
        uniform vec2  pointb;
        
        vec4 effect( vec4 color, Image texture, vec2 coo, vec2 screen_coords )
        {
          float r = mod(coo.x*coo.y,distance(pointr ,vec2(coo.x,coo.y)) ) ;      //return i*j%dist({x=0,y=0},{x=i,y=j})
          float g = mod(coo.x*coo.y,distance(pointg ,vec2(coo.x,coo.y))*coo.x);  //i*j%dist({x=max/2,y=max/2},{x=i,y=j})
          float b = mod(coo.x*coo.y,distance(pointb ,vec2(coo.x,coo.y))*0) ;     //i*j%dist({x=max,y=max},{x=i,y=j})
          
          return vec4(r,g,b,1) ;
        }
      ]]
      }
  
  
  for i,shader in ipairs( shaders_code) do
    shaders[i]=love.graphics.newShader(shader)
    print(i.." Loaded successfull")
  end
  
    t=getfenv()
   for k,v in pairs(t) do
    --print(i)
    if "function" ~= type(v) then
      print(k.." is a "..type(v))
      if "table" ~=type(v) then
        print(k.." = "..v)
      end
    end
    
   end
 
  t.count = 10
  
  setfenv(0,t)
  
  
  start =love.timer.getTime()
  s = getfenv()
  stop = love.timer.getTime()
  
  print(stop-start)
  
  
  print(s.count)
  
  fo = love.graphics.getFont()
  fo_hi = fo:getHeight()
  
  
  

  
  
  
end


function love.draw()
  --BEGIN_DRAW()

  
  
  love.graphics.setCanvas(canv)
    love.graphics.rectangle("fill",0,0,max,max)
  love.graphics.setCanvas()
  
  --love.graphics.draw(canv,0,0)
  imgui.Begin("debug_",true)
  
  s,shdr_idx = imgui.SliderInt("selected Shader",shdr_idx,1,#shaders)
  
  imgui.Separator()
  if shdr_idx == 2 then
     s,x_1,x_2 = imgui.SliderFloat2("multi_x",x_1,x_2,0,200)
     s,y_1,y_2 = imgui.SliderFloat2("multi_y",y_1,y_2,0,200)
     
    shaders[shdr_idx]:send("multi_x",x_1,y_2,0)
    shaders[shdr_idx]:send("multi_y",y_1,y_2,0)
    
    
   elseif shdr_idx == 4 then
     
     s,point_r[1],point_r[2] = imgui.SliderFloat2("pointr",point_r[1],point_r[2],0,1)
     s,point_g[1],point_g[2] = imgui.SliderFloat2("pointg",point_g[1],point_g[2],0,1)
     s,point_b[1],point_b[2] = imgui.SliderFloat2("pointb",point_b[1],point_b[2],0,1)
     
    shaders[shdr_idx]:send("pointr",point_r)
    shaders[shdr_idx]:send("pointg",point_g)
    shaders[shdr_idx]:send("pointb",point_b)
   end
  imgui.End()

  --use the shader
  love.graphics.setShader(shaders[shdr_idx])
    love.graphics.draw(canv)
  love.graphics.setShader()
  
  imgui.Render()
  
  local text =""
  for i=1 ,#line_buff do
   text = text ..line_buff[i].."\n"
  end
  love.graphics.print(text,0,0)
  
  
  --calculate the actual position and put a line there as cursor :P
  local cur_y = fo_hi*actual_line
  local cur_x = fo:getWidth(line_buff[actual_line]:sub(1,actual_pos+1))
    
    love.graphics.line(cur_x,cur_y,cur_x,cur_y-fo_hi)
  
  
  
  --END_DRAW()
end







function love.mousemoved(x, y)
    imgui.MouseMoved(x, y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousepressed(x, y, button)
    imgui.MousePressed(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.mousereleased(x, y, button)
    imgui.MouseReleased(button)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

function love.wheelmoved(x, y)
    imgui.WheelMoved(y)
    if not imgui.GetWantCaptureMouse() then
        -- Pass event to the game
    end
end

local shift_used = false





function add_key(key)
  if  #line_buff[actual_line] == LINE_BUFF_MAX then
    table.insert(line_buff,actual_line+1,"")
    line_buff[actual_line+1] = ""
    actual_line = actual_line+1
  end
  line_buff[actual_line] =line_buff[actual_line]..key
  actual_pos = actual_pos+1
end

function remove_key()
  if #line_buff[actual_line] > 0 then
    line_buff[actual_line] = line_buff[actual_line]:sub(1,#line_buff[actual_line]-1)
  else
    if actual_line >1 then
      table.remove(line_buff,actual_line)
      actual_line = actual_line -1
      actual_pos = #line_buff[actual_line]
    end
  
  end
  
end


function love.keypressed(key,code,rep_)
  --print(key.." "..code)
  if key == "return" then
    table.insert(line_buff,actual_line+1,"")
    line_buff[actual_line+1] = ""
    actual_line = actual_line+1
  elseif key == "backspace" then
    remove_key()
--  elseif key == "space" then
--   add_key(" ")
  elseif key == "left" then
    if actual_pos ~= 1 then
       actual_pos = actual_pos -1
       print(actual_pos)
    end

  elseif key == "right" then
    if actual_pos ~= #line_buff[actual_line] and actual_pos ~= LINE_BUFF_MAX then
       actual_pos = actual_pos+1
    end
    
  elseif key == "up" then
  actual_line = (actual_line>1) and actual_line-1 or actual_line
  
  elseif key == "down" then
  actual_line = (#line_buff>actual_line) and actual_line+1 or actual_line
  
  
  
--  elseif key:match(".*shift.*") then
--    shift_used = true
--  else
--    if shift_used then
--      if key:match("%d")then
--        print("I'm a number")
--      elseif key:match("%a") and #key == 1 then 
--        print("I'm a letter")
--        add_key( string.upper(key))
--      else
--        print("I'm something else "..#key)
--      end
--    else
--      if key:match("%d")then
--         print("I'm a number")
--         add_key(key)
--      elseif key:match("%a") and #key == 1 then 
--        print("I'm a letter")
--        add_key(key)
--      else  
--         print("I'm something else "..#key)
--      end
--    end
  end

  

end

function love.textinput(txt)
  
  
  
  add_key(txt)
end


function love.keyreleased(key)
  if key:match(".*shift.*") then
    shift_used = false
  end
end


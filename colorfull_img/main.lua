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
    
    for ro = 1,max do
      for co = 1,max do
        img[#img+1] = {
          re=r(ro,co),
          gr=g(ro,co),
          bl=b(ro,co)
          }
        
      end
    end
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

shdr_idx = 3
local shaders={}


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
  --END_DRAW()
end



function love.load()
  imgui = require("imgui")
    --require("mobdebug").start()
     
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
          float r = mod(coo.x*coo.y,distance(pointr,vec2(coo.x,coo.y)) ) ;      //return i*j%dist({x=0,y=0},{x=i,y=j})
          float g = mod(coo.x*coo.y,distance(pointg,vec2(coo.x,coo.y))*coo.x);  //i*j%dist({x=max/2,y=max/2},{x=i,y=j})
          float b = mod(coo.x*coo.y,distance(pointb,vec2(coo.x,coo.y))*0) ;     //i*j%dist({x=max,y=max},{x=i,y=j})
          
          return vec4(r,g,b,1) ;
        }
      ]]
      }
  
  
  for i,shader in ipairs( shaders_code) do
    shaders[i]=love.graphics.newShader(shader)
    print(i.." Loaded successfull")
  end
  
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


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




function dark_col(i)
    love.graphics.setColor(palette[dark[i]])
end


function love.update(dt)
  
  
end





function love.load()
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
      }
      
      start_t = love.timer.getTime()
end



function base_idea()
    love.graphics.setColor(0xff,0xff,0xff,255)
    
  --get some time since the start
  local a = (love.timer.getTime()-start_t)
  --print(a)
  
  
  --love.graphics.setCanvas(canv)
   for i = 0,3*(math.pi/2),math.pi/2 do
     --print(i)
     local x1 = 64+32*math.cos(a+i)
     local x2 = 64+32*math.cos(a+i+(math.pi/2))
     
     if x1 <x2 then
       --draw the rectangle
       love.graphics.setColor(0xff,0xff,0xff,255)
       love.graphics.rectangle("fill",x1,0,dist({x=x1,y=0},{x=x2,y=0}),127) -- x1 ,0 to x2,127

       
       --draw the "lines"
       love.graphics.setColor(0,0,0,255)
       
       love.graphics.rectangle("line",x1,0,1,127)
       love.graphics.rectangle("line",x2,0,1,127)
     end
     
     
   end
end


function turn_to_rad(angle)
  return angle*6.28
end







local funky_ =
{
  1,2,13,14,2,3,15,16,8
}

local iLines  = 128
local center = 64
local width  = 32


function twisted_thingy()
  love.graphics.setColor(0xff,0xff,0xff,255)
    
  --get some time since the start
  local t = (love.timer.getTime()-start_t)
  --print(a)
  
  --draw line after line
  for y=0,iLines do
    local yy = y/1024--find out what
    --local a  = math.cos(turn_to_rad(0.2*math.sin(turn_to_rad(t*0.1+yy*2)))+0.5*math.cos(turn_to_rad(-0.2*t+yy/2)))  --time stuff depending on y , makes things twist :P
    --local a  = math.cos(turn_to_rad(turn_to_rad(0.1)*math.sin(turn_to_rad(t*0.1+yy*2)))+turn_to_rad(0.5)*math.cos(turn_to_rad(-0.2*t+yy/2)))  --time stuff depending on y , makes things twist :P
    local a  =  (math.cos(yy) +t +math.sin(yy*20+t)) --yy*t --time stuff depending on y , makes things twist :P
    
    local center = 64+16*math.cos(math.sin(turn_to_rad(t*0.1+yy*2)))
    local width  =32+4*(math.sin(turn_to_rad(-t+y/128))+turn_to_rad(0.5)*math.cos(0.5*t-y/64))
     
    --for each side that 
     for i = 0,3*(math.pi/2),(math.pi/2) do
       --print(i)
       local x1 = center+width*math.cos(a+i)
       local x2 = center+width*math.cos(a+i+(math.pi/2))
       
       if x1 <x2 then
          col_num =   math.floor(dist({x=x1,y=0},{x=x2,y=0}))%255 * 5
       
               
       
         love.graphics.setColor(col_num,col_num,col_num)
         --love.graphics.setColor(palette[ca])
         love.graphics.line(x1,y,x2,y)
         
         
         --draw the "ends"
         --love.graphics.setColor(0xff,0xff,0xff,255)
         --love.graphics.setColor(0,0,0,255)
         --love.graphics.points(x1,y,x2,y)
         
       end
       
       
     end
   end
   
end



canv = love.graphics.newCanvas(screen_width,screen_height)
function love.draw()
  --BEGIN_DRAW()

   
   
    --twisted_thingy()
    
    base_idea()
 
 love.graphics.setColor(0xff,0xff,0xff,255)
  
  --print(love.timer.getFPS())
  
  --END_DRAW()
end










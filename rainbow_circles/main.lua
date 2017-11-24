local screen_width, screen_height = love.graphics.getWidth(),love.graphics.getHeight()
local circles = {}
local num_of_circles = 15

love.graphics.setLineStyle('rough')
local canvas = love.graphics.newCanvas(screen_width, screen_height)
canvas:setFilter('nearest','nearest')


function Clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end


local palette = {
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


local color_lookup= {

}


local circle_mode = true



local dark = {
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


local alpha_mod =[[
vec4 effect( vec4 color, Image texture, vec2 texture_coords, vec2 screen_coords )
{
    vec4 c = Texel(texture, texture_coords);
    return c;
}
]]
function create_circle()
  local tmp =       
  {
      x = math.random(5,screen_width-1),
      y= math.random(5,screen_height-1),
      size = math.random(1,5),
      color = math.random(8,#palette-2)
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



function love.load()
  --require ("mobdebug").start()
  -- initialise some circle objects
  for i=1 ,num_of_circles do
    circles[i] = create_circle()
  end
  create_lookup()
  love.graphics.setLineWidth(3)
  
  sh = love.graphics.newShader(alpha_mod)
  
end


function BEGIN_DRAW()
  love.graphics.setCanvas(canvas)
  love.graphics.setLineWidth(1)
  local data = canvas:newImageData()
  for i = 1, 1500 do
    local x,y=math.random(0,screen_width-1),math.random(0,screen_height-1)
    -- If we want to do something based on the color at the pixel x,y
    local r,g,b=data:getPixel(x,y)
    -- if math.random(1000) > 600 then
         love.graphics.setColor(palette[rainbow[color_lookup[r][g][b]]])
    -- else
     -- love.graphics.setColor(r,g,b)
     --end
      
    -- the dithering effect
    love.graphics.circle("fill",x-math.random(-10,10),y-math.random(-10,10),2,4)
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
  love.graphics.setColor(palette[math.floor(i) % 16 + 1])
end

function dark_col(i)
    love.graphics.setColor(palette[dark[i]])
end



function love.update(dt)

--update the circles
if circle_mode then
  for i,circle in ipairs(circles) do
      if math.random(0,600)> 500 then
        circles[i].size =  circles[i].size +1
      end
      
      if circle.size > 50 then
        circles[i] = create_circle() 
      end
  end
end
  
end

function love.draw()
  --love.graphics.setCanvas(canvas)
  BEGIN_DRAW()
  
  color(1)
  love.graphics.line(0,screen_height,screen_width,screen_height)
  love.graphics.line(screen_width,0,screen_width,screen_height)
  
--  love.graphics.setShader(sh)

  
  
  if circle_mode then
    for i, circle in ipairs(circles) do
      color(circle.color)
      love.graphics.circle("line",circle.x,circle.y,circle.size)
     -- dark_col(circle.color)
     -- love.graphics.circle("line",circle.x,circle.y,circle.size)
    end
  else
    local mx,my = love.mouse.getPosition()
    color(11)
    love.graphics.circle("line",mx,my,3,10)
  end

  --also draw a color like the background on the bottom ...
  
  END_DRAW()
  love.graphics.setShader()
  
  
  print(love.timer.getFPS())
end


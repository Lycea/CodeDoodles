local screen_width, screen_height = love.graphics.getWidth(),love.graphics.getHeight()
local circles = {}
local num_of_circles = 20

love.graphics.setLineStyle('rough')
local canvas = love.graphics.newCanvas(screen_width, screen_height)
canvas:setFilter('nearest','nearest')





local color_lookup = { }


local circle_mode = true
local balls_mode  = false
local balls ={}

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
  [0]=0
  }







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



function get_destination(ball_)
  local found_point = false
  local dest = {}
  local idest 
  repeat
    repeat
     idest = math.random(1,4)
    until idest ~= ball_.dest.side
      
    --top
    if idest == 1 then
      dest.y = 0
      dest.x = math.random(0,screen_width)
      
    --right
    elseif idest == 2 then
      dest.y = math.random(0,screen_height)
      dest.x = screen_width
    --bot
    elseif idest == 3 then
      dest.y = screen_height
      dest.x = math.random(0,screen_width)
    --left
    elseif idest ==4 then
      dest.y = math.random(0,screen_height)
      dest.x = 0
    end
    dest.side = idest
   found_point = true
  until found_point == true
  return dest
end


function create_ball()
  local tmp =       
  {
    start ={
      x = math.random(5,screen_width-5),
      y= math.random(5,screen_height-5)
      },
      color = 10--math.random(8,#palette-2)
   }
   
   if tmp.start.x > screen_width/2 then
     tmp.dest = {}
     tmp.dest.x = math.random(10,screen_width)
     tmp.dest.y = 0
     
     tmp.dest.side = 1
   else
     tmp.dest = {}
     tmp.dest.x = math.random(screen_width/2+1,screen_width)
     tmp.dest.y = screen_height
     tmp.dest.side = 3
   end
    tmp.time = 0
  return tmp
end


function bounce(p_ball)
  p_ball.start.x = p_ball.x
  p_ball.start.y = p_ball.y
  
  p_ball.dest =get_destination(p_ball)
  
end




function love.load()
  --require ("mobdebug").start()
  -- initialise some circle objects
  
  love.mouse.setVisible(false)
  
  for i=1 ,num_of_circles do
    circles[i] = create_circle()
  end
  create_lookup()
  love.graphics.setLineWidth(3)
  
  sh = love.graphics.newShader(alpha_mod)
  
  
  for i=1,num_of_circles do
    balls[i] = create_ball()
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
local time_old = 0
function dark_col(i)
    love.graphics.setColor(palette[dark[i]])
end



function love.update(dt)
--print(dt)
if dt > 0.5 then
  return
end

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
  elseif balls_mode then
  
    for i,ball in ipairs(balls) do
     ball.x,ball.y= lerp_point(ball.start.x,ball.start.y,ball.dest.x,ball.dest.y,ball.time)
     if dist(ball,ball.dest) <10 then
        bounce(ball)
        ball.time = 0
       -- print("Bounce "..i)
     end
     if i == 1 then
    -- print("Ball "..i.." dist: "..dist(ball,ball.dest))
    end
   
     ball.time = ball.time +dt/2
     
    end
    
  else
    
  end
  
end




function love.draw()
  --love.graphics.setCanvas(canvas)
  BEGIN_DRAW()
  
  color(1)
  love.graphics.line(0,screen_height,screen_width,screen_height)
  love.graphics.line(screen_width,0,screen_width,screen_height)
  
  color(8)
  --love.graphics.print("Hello world ",0,0)
--  love.graphics.setShader(sh)


  
  if circle_mode then
    for i, circle in ipairs(circles) do
      color(circle.color)
      love.graphics.circle("line",circle.x,circle.y,circle.size)
     -- dark_col(circle.color)
     -- love.graphics.circle("line",circle.x,circle.y,circle.size)
    end
  elseif balls_mode then
    color(col-1)
    for i,ball in ipairs(balls) do
      love.graphics.circle("fill",ball.x,ball.y,10,100)
    end
  
    
  else
    local mx,my = love.mouse.getPosition()
    
    color(col-1)
    love.graphics.circle("fill",mx,my,10,10)
    

  end

  --also draw a color like the background on the bottom ...
  
  END_DRAW()
  
  love.graphics.setShader()
  
  
  --print(col)
  
  --print(love.timer.getFPS())
end

  
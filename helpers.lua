local helper = {}
----color paletts and relevant functions
helper.colors={}
helper.colors.pico8 =
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


function helper.colors.create_lookup(palette)
   local color_lookup = {}
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
   return color_lookup
end


--mathematic functions lice calculating distances or interpolate over data ...
function helper.lerp_(x,y,t) local num = x+t*(y-x)return num end

function helper.lerp_point(x1,y1,x2,y2,t)
  local x = helper.lerp_(x1,x2,t)
  local y = helper.lerp_(y1,y2,t)
  --print(x.." "..y)
  return x,y
end


function helper.dist(p1,p2) return ((p2.x-p1.x)^2+(p2.y-p1.y)^2)^0.5 end



function helper.Clamp(val, lower, upper)
    assert(val and lower and upper, "not very useful error message here")
    if lower > upper then lower, upper = upper, lower end -- swap if boundaries supplied the wrong way
    return math.max(lower, math.min(upper, val))
end




return helper
local module_name ={}
--local BASE = (...)..'.' 
--local i= BASE:find("dungeon")
--BASE=BASE:sub(1,i-1)

--Delaunay = require(BASE .. 'src.delaunay')

------------------------------NEEDED FUNCTIONS-------------------------
function module_name.init()
  
end


function module_name.update(dt)
  
  
end

function module_name.draw()
  
  love.graphics.line(10,10,20,20)
end









----------------------------Optional Functions---------------------------

--key callbacks
function module_name.keypressed(key,code,rep_)
  
end



function module_name.keyreleased(key)
  
end


--text callbacks
function module_name.textinput(txt)
  
end



--when requiring this will return the functions in a value
return module_name
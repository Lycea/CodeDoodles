local file_list = {}
local base 
local base_temp =""

function check_point(name)
  if name == "." or name == ".." then
    return true
  else
    return false
  end
end


function parse_files(path)
  local lines_ ={}
  --print("-----------------")
  --print(path)
  
  --find all lines and save them to the array
  while true do
     local idx = string.find(path,"\n")


     if idx then
       local left_txt = string.sub(path,idx+1,#path-1)
       local line_part = string.sub(path,0,idx-1)
       
       if line_part:find("Volume in drive") or line_part:find("Volume Serial") 
         or line_part:find("Directory of")   
         or line_part:find("File(s)") then
         
         path = left_txt
       else
         --check if it is a directory and get the name
         local text = line_part:match(".*DIR. +(.+)")
         
         --if it is a folder ad to list
         if text then
           --print(text)
          lines_[#lines_+1] ={}
          lines_[#lines_].name = text
          if check_point(lines_[#lines_].name ) == false then
            lines_[#lines_].has_child = true
            --print(base_temp)
            base_temp = base_temp..lines_[#lines_].name.."\\"
            --print(base_temp)
            lines_[#lines_].child = parse_files(get_files(base_temp))
            
          else
            lines_[#lines_].has_child = false
          end
          
          --print()
         else
           text = line_part:match("^%d.+ (.+)")
           --it is a file add it to the list
           if text then
             lines_[#lines_+1] ={}
             lines_[#lines_].name = text
             lines_[#lines_].has_child = false
           end
         end
         path = left_txt
       end
       
     else
       break
     end
     
  end
  
  --base_temp = base_temp:match("^%L:\\[^.-%a]*\\")
  base_temp = base_temp:match("(.*\\).")
  --print("END: "..base_temp)
  
 return lines_
end


function get_files(path)
  local f = io.popen("dir \""..path.."")

  if f then
       data = f:read("*a")
      return data
  else
      print("failed to read")
  end
end


function printSpecial(txt,layers)
  temp_string = ""
  
  for j = 1, layers do
    temp_string = temp_string.."  "
  end
  print(temp_string..txt)
end


function start(p)  
  p= p.. "\\"
  --print(p)
  local test = string.match(p,".+\\")
  base = test
  base_temp = test
  local fi = get_files(test)
  local list = parse_files(fi)
  --print(list)
  
  
  --
  -- FROM HERE JUST EXAMPLE PRINTING OF THE LIST DO WHATEVER YOU WANT WITH IT
  --
  
  
--  local save_list = {}
--  local save_iterator = {}
--  local save_layer_max_iterator = {}
--  local actual_layer = 1
--  local old_layer = 1
--  local did_something 
  
--  save_iterator[actual_layer] = #list
--  save_list[actual_layer] = list
--  while true do
--    did_something = false
    
--    if old_layer < actual_layer then
--      save_iterator[actual_layer] = #list+1
--      save_layer_max_iterator[actual_layer] = nil
--    else
--     if old_layer > actual_layer then
--       list = save_list[actual_layer]
--     end
--    end
    
--    if save_layer_max_iterator[actual_layer] then start_count=save_layer_max_iterator[actual_layer]+1 else start_count=1 end
--    --print folders/files
--    for i= start_count,save_iterator[actual_layer] do 
      
--      if list[i]~= nil then
--        printSpecial(list[i].name,actual_layer)
        
--        if list[i].has_child then
--        list = list[i].child
--        save_list[actual_layer+1] = list
--        save_layer_max_iterator[actual_layer] = i
--        old_layer = actual_layer
--        actual_layer = actual_layer + 1
--        did_something = true
--        break
--        end
        
--        --other case for checking if something happend
--        if list[i].has_child == nil  and i+1 ~= save_iterator[actual_layer]then
--          did_something = true
--        end
        
--        if i+1 == save_iterator[actual_layer] then
--          old_layer = actual_layer
--           actual_layer =actual_layer -1
--           --i = save_layer_max_iterator[actual_layer]
--           did_something = true
--           break
--        end
        
--      else
        
--      end
      
      
      
      
--    end
    
--    if did_something == false then
--      old_layer = actual_layer
--      actual_layer = actual_layer -1
--    end
    
--    if actual_layer == 0 then
--      break
--    end
    
    
--  end
  return list
  
end




--start()
--return file_list


local _M = {}
local cjson = require "cjson.safe"

function _M.execute_header(conf)
  if conf.say_hello then
    ngx.log(ngx.ERR, "============ Hello World Header! ============")
    ngx.header["Hello-World"] = "Hello World!!!"
  end
end

function _M.execute_body(conf,chunks)
  if conf.say_hello_body then
    ngx.log(ngx.ERR, "============ Hello World Body! ============")
    hello = "hello"
    if chunks ~= nil then
      return append_value(chunks,hello)
    end
  else
    return chunks
  end
end

local function append_value(current_value, value)
  local current_value_type = type(current_value)

  if current_value_type  == "string" then
    return {current_value, value }
  end

  if current_value_type  == "table" then
    insert(current_value, value)
    return current_value
  end

  return { value }
end

return _M
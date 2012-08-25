pcall(require, 'luarocks.require')

local _G = getfenv(0)

-- Load Test.More into an isolated environment
local test = setmetatable({}, { __index = _G })
test._G    = test
setfenv(0, test) -- XXX this won't work in Lua 5.2
require 'Test.More'
local tb = require('Test.Builder'):new()
setfenv(0, _G)
setmetatable(test, nil)

package.path = package.path .. ';./?/init.lua'
LIB_NAME     = 'require'

function test.is_callable(value, name)
  local type = type(value)
  local result

  if type == 'function' then
    result = true
  else
    local metatable = getmetatable(value)

    result = metatable and metatable.__call
  end

  tb:ok(result, name)
  return result
end

function test.is_tablelike(value, name)
  local type = type(value)
  local result

  if type == 'table' then
    result = true
  else
    local metatable = getmetatable(value)


    result = metatable and metatable.__index and metatable.__newindex
  end

  tb:ok(result, name)
  return result
end

return test

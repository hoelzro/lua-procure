pcall(require, 'luarocks.require')

local _G  = getfenv(0)
local lfs = require 'lfs'

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

local os_name = os.getenv 'OS'

if os_name == 'Linux' then
  DYNLIB_EXT = '.so'
elseif os_name == 'Darwin' then
  DYNLIB_EXT = '.dylib'
else
  test.diag(os_name)
end

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

function test.cmp_sets(got, expected, name)
  local ok = true

  for k, got_v in pairs(got) do
    local expected_v = expected[k]

    if got_v ~= expected_v then
      ok = false
      break
    end
  end

  if ok then
    for k, expected_v in pairs(expected) do
      local got_v = got[k]

      if got_v ~= expected_v then
        ok = false
        break
      end
    end
  end

  tb:ok(ok, name)
  return ok
end

local function find(root, action)
  local ok, errormsg = pcall(function()
    for entry in lfs.dir(root) do
      if entry ~= '.' and entry ~= '..' then
        entry = root .. '/' .. entry -- XXX Be sensitive to non-unixes
        local type = lfs.attributes(entry).mode

        if type == 'directory' then
          find(entry, action)
        else
          action(entry)
        end
      end
    end

    action(root)
  end)

  if not ok then
    io.stderr:write(errormsg .. '\n')
  end
end

function test.tempdir()
  local tempdir = newproxy(true)
  local meta    = getmetatable(tempdir)
  local filename

  while not filename do
    local name = os.tmpname()
    os.remove(name)
    local success = lfs.mkdir(name)

    if success then
      filename = name
    end
  end

  function meta:__gc()
    find(filename, function(path)
      os.remove(path)
    end)
  end

  function meta:__tostring()
    return filename
  end

  function meta.__concat(lhs, rhs)
    if type(lhs) ~= 'string' then
      lhs = tostring(lhs)
    end

    if type(rhs) ~= 'string' then
      rhs = tostring(rhs)
    end

    return lhs .. rhs
  end

  return tempdir
end

function test.unslurp(filename, contents)
  local h = assert(io.open(filename, 'w'))

  h:write(contents)

  h:close()
end

return test

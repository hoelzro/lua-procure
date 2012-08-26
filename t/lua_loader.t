-- vim:ft=lua sw=2 sts=2

local test    = require 't.setup'
local require = require(LIB_NAME)
local lfs     = require 'lfs'

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

local function tempdir()
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

local function unslurp(filename, contents)
  local h = assert(io.open(filename, 'w'))

  h:write(contents)

  h:close()
end

local td     = tempdir()
package.path = td .. '/?.lua'

unslurp(td .. '/table_return.lua', [[
return { foo = 17 }
]])

unslurp(td .. '/no_return.lua', [[
_G.bar = 17
]])

unslurp(td .. '/nil_return.lua', [[
return nil
]])

unslurp(td .. '/false_return.lua', [[
return false
]])

unslurp(td .. '/assign_loaded_noreturn.lua', [[
local name = ...
package.loaded[name] = { foo = 17 }
]])

unslurp(td .. '/assign_loaded_return.lua', [[
local name = ...
package.loaded[name] = { foo = 17 }

return { bar = 18 }
]])

test.plan(17)

do -- check table_return results
  local result = require 'table_return'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    foo = 17
  })

  test.is(result, package.loaded.table_return)
end

do -- check no_return results
  test.is(_G.bar, nil)
  local result = require 'no_return'
  test.is(_G.bar, 17)

  test.is(result, true)
  test.is(result, package.loaded.no_return)
end

do -- check nil_return results
  local result = require 'nil_return'

  test.is(result, true)
  test.is(result, package.loaded.nil_return)
end

do -- check false_return results
  local result = require 'false_return'

  test.is(result, false)
  test.is(result, package.loaded.false_return)
end

do -- check assign_loaded_noreturn results
  local result = require 'assign_loaded_noreturn'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    foo = 17
  })

  test.is(result, package.loaded.assign_loaded_noreturn)
end

do -- check assign_loaded_return results
  local result = require 'assign_loaded_return'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    bar = 18
  })

  test.is(result, package.loaded.assign_loaded_return)
end

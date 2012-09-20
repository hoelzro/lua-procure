-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

function package.preload.preload()
  return {
    foo = 17,
  }
end

local td      = test.tempdir()
package.path  = td .. '/?.lua'
package.cpath = 't_c/?' .. DYNLIB_EXT

test.plan(14)

do -- test preload
  local result = require.findchunk 'preload'
  test.ok(result, 'test that the result is not nil')
  result = result 'preload'
  test.is(result.foo, 17)
end

do -- test regular loader
  test.unslurp(td .. '/lua.lua', [[
return { foo = 18 }
  ]])

  local result = require.findchunk 'lua'
  test.ok(result, 'test that the result is not nil')
  result = result 'lua'
  test.is(result.foo, 18)
end

do -- test C loader
  local result = require.findchunk 'table_return'
  test.ok(result, 'test that the result is not nil')
  result = result 'table_return'
  test.is(result.foo, 17)
end

do -- test all-in-one-loader
  local result = require.findchunk 'all_in_one.table_return'
  test.ok(result, 'test that the result is not nil')
  result = result 'all_in_one.table_return'
  test.is(result.foo, 17)
end

do -- test not found
  package.path = 't_c/?.lua'

  local result, message = require.findchunk 'absent.module'
  test.ok(not result)
  test.like(message, "module 'absent.module' not found")
  test.like(message, "no field package%.preload%['absent%.module'%]")
  test.like(message, "no file 't_c/absent/module%.lua'")
  test.like(message, "no file 't_c/absent/module%" .. DYNLIB_EXT .. "'")
  test.like(message, "no file 't_c/absent%" .. DYNLIB_EXT .. "'")
end

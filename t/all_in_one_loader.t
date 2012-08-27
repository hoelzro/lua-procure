-- vim:ft=lua sw=2 sts=2

local test    = require 't.setup'
local require = require(LIB_NAME)

package.cpath = 't_c/?' .. DYNLIB_EXT

test.plan(17)

do -- check table_return results
  local result = require 'all_in_one.table_return'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    foo = 17
  })

  test.is(result, package.loaded['all_in_one.table_return'])
end

do -- check no_return results
  test.is(_G.bar, nil)
  local result = require 'all_in_one.no_return'
  test.is(_G.bar, 17)

  test.is(result, true)
  test.is(result, package.loaded['all_in_one.no_return'])
end

do -- check nil_return results
  local result = require 'all_in_one.nil_return'

  test.is(result, true)
  test.is(result, package.loaded['all_in_one.nil_return'])
end

do -- check false_return results
  local result = require 'all_in_one.false_return'

  test.is(result, false)
  test.is(result, package.loaded['all_in_one.false_return'])
end

do -- check assign_loaded_noreturn results
  local result = require 'all_in_one.assign_loaded_noreturn'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    foo = 17
  })

  test.is(result, package.loaded['all_in_one.assign_loaded_noreturn'])
end

do -- check assign_loaded_return results
  local result = require 'all_in_one.assign_loaded_return'

  test.is(type(result), 'table')
  test.cmp_sets(result, {
    bar = 18
  })

  test.is(result, package.loaded['all_in_one.assign_loaded_return'])
end

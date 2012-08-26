-- vim:ft=lua sw=2 sts=2

local test    = require 't.setup'
local require = require(LIB_NAME)

package.cpath = 't_c/?.so' -- XXX hardcoded dynamic library extension

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

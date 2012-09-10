-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

test.plan(8)

package.preload['test-preload'] = function(name)
  return { preload = true, name = name }
end

local td      = test.tempdir()
package.path  = td .. '/?.lua'
package.cpath = 't_c/?.so' -- XXX hardcoded dynamic library extension

test.unslurp(td .. '/test-lua.lua', [[
local name = ...

return {
  lua  = true,
  name = name,
}
]])

local result

result = require 'test-preload'
test.ok(package.loaded['test-preload'])
test.cmp_sets(result, {
  preload = true,
  name    = 'test-preload',
})

result = require 'test-lua'
test.ok(package.loaded['test-lua'])
test.cmp_sets(result, {
  lua  = true,
  name = 'test-lua',
})

result = require 'test-c'
test.ok(package.loaded['test-c'])
test.cmp_sets(result, {
  c    = true,
  name = 'test-c',
})

result = require 'test-all_in_one.c'
test.ok(package.loaded['test-all_in_one.c'])
test.cmp_sets(result, {
  all_in_one = true,
  name       = 'test-all_in_one.c',
})

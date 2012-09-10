-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

test.plan(5)

local n_runs = 0

function package.preload.test_lib()
  n_runs = n_runs + 1
  return { foo = 17 }
end

local result

test.is(n_runs, 0)

result = require 'test_lib'
test.is(n_runs, 1)
test.cmp_sets(result, {
  foo = 17
})

result = require 'test_lib'
test.is(n_runs, 1)
test.cmp_sets(result, {
  foo = 17
})

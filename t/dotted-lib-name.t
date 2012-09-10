-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

test.plan(3)

package.preload.foo = {
  bar = function()
    return { foo = 17 }
  end,
}

local ok = pcall(require, 'foo.bar')

test.ok(not ok)

package.preload['foo.bar'] = function()
  return { foo = 17 }
end

local result = require 'foo.bar'

test.cmp_sets(result, {
    foo = 17,
})

test.cmp_sets(package.loaded['foo.bar'], {
    foo = 17,
})

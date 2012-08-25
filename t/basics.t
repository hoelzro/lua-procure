-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

test.plan(3)

test.ok(require)
test.is_callable(require)
test.is_tablelike(require)

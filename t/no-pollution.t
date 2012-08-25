-- vim:ft=lua sts=2 sw=2

local test = require 't.setup'

local function softcopy(t)
  local copy = {}

  for k, v in pairs(t) do
    copy[k] = v
  end

  return copy
end

test.plan(1)

local pre_globals = softcopy(_G)
require(LIB_NAME)

test.cmp_sets(_G, pre_globals)

-- vim:ft=lua sts=2 sw=2

local test    = require 't.setup'
local require = require(LIB_NAME)

local function collect_keys(t)
  local keys = {}

  for k in pairs(t) do
    keys[k] = true
  end

  return keys
end

local function test_require(params)
  local require = params.require or require
  local chunk   = params.chunk
  local effects = params.global_effects

  if not chunk then
    test.fail "parameter 'chunk' required"
    return
  end

  if not effects then
    test.fail "parameter 'global_effects' required"
    return
  end

  package.path         = ''
  package.cpath        = ''
  package.preload.test = chunk

  local before_keys = collect_keys(_G)
  require 'test'

  package.preload.test = nil
  package.loaded.test  = nil

  local got_effects = {}

  for k, v in pairs(_G) do
    if before_keys[k] == nil then
      got_effects[k] = v
      _G[k]          = nil
    end
  end

  test.cmp_sets(got_effects, effects)
end

test.plan(6)

do -- sanity checks
  test_require {
    chunk = function(name)
      foo = 17
    end,
    global_effects = {
      foo = 17,
    }
  }

  test_require {
    chunk = function(name)
      _G.foo = 17
    end,
    global_effects = {
      foo = 17,
    }
  }

  test_require {
    chunk = function(name)
      getfenv(0).foo = 17
    end,
    global_effects = {
      foo = 17,
    }
  }
end

do
  test_require {
    require = require.isolated,
    chunk   = function(name)
      foo = 17
    end,
    global_effects = {},
  }

  test_require {
    require = require.isolated,
    chunk   = function(name)
      _G.foo = 17
    end,
    global_effects = {},
  }

  test_require {
    require = require.isolated,
    chunk   = function(name)
      getfenv(0).foo = 17
    end,
    global_effects = {
      foo = 17,
    },
  }
end

-- XXX what happens if I procure.isolated() a module that
--     already behaves well with regards to the global env?

-- XXX consider this:
--
--     function package.preload.mymod()
--       require 'lfs'
--       -- now we define stuff using lfs' stuff
--       -- like it's in our global env
--     end
--     require.isolated 'mymod'
--     require 'lfs'
--
--     -- are lfs' functions in my global env now?

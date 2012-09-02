-- vim:ft=lua sw=2 sts=2

local test    = require 't.setup'
local require = require(LIB_NAME)

local EXT = 'so' -- XXX hardcoded extension

test.plan(6)

package.path  = 't_c/?.lua'
package.cpath = 't_c/?.' .. EXT

do -- absent module
  local ok, message = pcall(require, 'absent.module')

  test.ok(not ok)
  test.like(message, "module 'absent.module' not found")
  test.like(message, "no field package%.preload%['absent%.module'%]")
  test.like(message, "no file 't_c/absent/module%.lua'")
  test.like(message, "no file 't_c/absent/module%." .. EXT .. "'")
  test.like(message, "no file 't_c/absent%." .. EXT .. "'")
end

test.done_testing()

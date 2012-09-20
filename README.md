lua-procure - A Pure Lua Implementation of require()
====================================================

This library is a pure Lua implementation of `require()`.  It exists as a reference
for people experienced in Lua but not C and would like a code-based way of looking
at how `require()` hows.  However, that isn't the only purpose of this library; I intend
to deliver more advanced features on top of the basic `require()` functionality.

For more information, see this thread on the Lua mailing list:

http://lua-users.org/lists/lua-l/2012-08/msg00207.html

Usage
=====

If you want to try this library out, all you need to do is this:

```lua

local require = require 'procure'

```

And `require()` statements in the current chunk will use the pure Lua variant.
If you're feeling dangerous, you could always override the global one:

```lua

_G.require = require 'procure'

```

Additional Methods/Functions
============================

In addition to the `require()` functionality that this library supports, it also
supports other methods and functions related to loading libraries.

### procure.findchunk(name)

This function finds the code chunk that require itself would load and returns it.
If no library is found with the name `name`, `nil` and an error message are returned.
An example usage for this would be to load plugins for a program; you want to use
require's loaders to find a plugin, but you want to be able to run them in a custom
environment.

### procure.isolated(name)

This function behaves exactly like `procure()`, except the module specified by `name`
is loaded in an isolated environment (it cannot make changes to the global environment).
This is to allow users who want to keep a clean global environment to use modules that
"misbehave" in this regard.

It's not *entirely* impossible for isolated modules to alter the global environment; while
naïve global assignment (assigning to a variable not declared with `local`) and assigning
to `_G` will be intercepted, assigning to keys in the value returned by `getfenv(0)` (for
example) will not.  I feel this is a proper balance between cleanliness and flexibility.

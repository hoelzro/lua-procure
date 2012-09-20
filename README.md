lua-procure - A Pure Lua Implementation of require()
====================================================

**NOTE**: I intend to change this name very soon; I wanted to get some code down
first, so I haven't had to chance to think of a good one.  Suggestions are welcome!
Please keep in mind that as a result, I will rename the repository on Github once
I've settled on a good name.  So if you're tracking my progress, don't be alarmed if
it disappears. =)

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

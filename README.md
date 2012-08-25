lua-require - A Pure Lua Implementation of require()
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

local require = require 'require'

```

And `require()` statements in the current chunk will use the pure Lua variant.
If you're feeling dangerous, you could always override the global one:

```lua

_G.require = require 'require'

```

Roadmap
=======

0.01
----

  * drop in replacement for require()
  * luarocks loader
  * name
  * isolated loader
  * can a module return multiple values? if so, what goes into package.loaded?

Later
-----

  * Lua 5.2 compability
  * Lua 5.0 compability
  * Test suite running on OS X
  * it would be cool if loaders could say "continue with other loaders, with this change in parameters"
  * require:findchunk(modulename)
  * procure.relative(modname)
  * procure.import(modname, args) -- expects a a 5.2-style module, with an optional import routine
  * procure.withenv(modname, env)
  * procure.mycustomloadertype (ex. luvit)

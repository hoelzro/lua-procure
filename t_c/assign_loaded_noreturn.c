#include <lua.h>

int
luaopen_assign_loaded_noreturn(lua_State *L)
{
    lua_getglobal(L, "package");
    lua_getfield(L, -1, "loaded");

    lua_pushvalue(L, 1); // push the name
    lua_newtable(L);
    lua_pushinteger(L, 17);
    lua_setfield(L, -2, "foo");
    lua_settable(L, -3);

    return 0;
}

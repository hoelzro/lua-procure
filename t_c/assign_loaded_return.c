#include <lua.h>

int
luaopen_assign_loaded_return(lua_State *L)
{
    lua_getglobal(L, "package");
    lua_getfield(L, -1, "loaded");

    lua_pushvalue(L, 1); // push the name
    lua_newtable(L);
    lua_pushinteger(L, 17);
    lua_setfield(L, -2, "foo");
    lua_settable(L, -3);

    lua_newtable(L);
    lua_pushinteger(L, 18);
    lua_setfield(L, -2, "bar");

    return 1;
}

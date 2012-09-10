#include <lua.h>

int
luaopen_all_in_one_c(lua_State *L)
{
    lua_newtable(L);
    lua_pushboolean(L, 1);
    lua_setfield(L, -2, "all_in_one");
    lua_pushvalue(L, 1);
    lua_setfield(L, -2, "name");

    return 1;
}

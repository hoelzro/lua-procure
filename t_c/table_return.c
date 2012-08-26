#include <lua.h>

int
luaopen_table_return(lua_State *L)
{
    lua_newtable(L);
    lua_pushinteger(L, 17);
    lua_setfield(L, -2, "foo");
    return 1;
}

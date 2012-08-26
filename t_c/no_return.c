#include <lua.h>

int
luaopen_no_return(lua_State *L)
{
    lua_pushinteger(L, 17);
    lua_setglobal(L, "bar");

    return 0;
}

#include <lua.h>

int
luaopen_nil_return(lua_State *L)
{
    lua_pushnil(L);
    return 1;
}

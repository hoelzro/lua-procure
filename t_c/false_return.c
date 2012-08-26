#include <lua.h>

int
luaopen_false_return(lua_State *L)
{
    lua_pushboolean(L, 0);
    return 1;
}

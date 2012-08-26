#include <lua.h>

int
luaopen_all_in_one_table_return(lua_State *L)
{
    lua_newtable(L);
    lua_pushinteger(L, 17);
    lua_setfield(L, -2, "foo");
    return 1;
}

int
luaopen_all_in_one_no_return(lua_State *L)
{
    lua_pushinteger(L, 17);
    lua_setglobal(L, "bar");

    return 0;
}

int
luaopen_all_in_one_nil_return(lua_State *L)
{
    lua_pushnil(L);
    return 1;
}

int
luaopen_all_in_one_false_return(lua_State *L)
{
    lua_pushboolean(L, 0);
    return 1;
}

int
luaopen_all_in_one_assign_loaded_noreturn(lua_State *L)
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

int
luaopen_all_in_one_assign_loaded_return(lua_State *L)
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

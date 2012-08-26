local meta = {}
local _M   = setmetatable({}, meta)

_M.VERSION = '0.01'

local function require(name)
  if package.loaded[name] == nil then
    local errors = { string.format("module '%s' not found", name) }
    local found

    for _, loader in ipairs(_M.loaders) do
      local chunk = loader(name)

      if type(chunk) == 'function' then
        local result = chunk(name)
        found        = true

        if result ~= nil then
          package.loaded[name] = result
        elseif package.loaded[name] == nil then
          package.loaded[name] = true
        end

        break
      elseif type(chunk) == 'string' then
        errors[#errors + 1] = chunk
      end
    end

    if not found then
      errors = table.concat(errors, '')
      error(errors, 2)
    end
  end

  return package.loaded[name]
end

_M.loaders = {}

local loader_names = {
  'preload_loader',
  'lua_loader',
  'c_loader',
  'all_in_one_loader',
}

local loadermeta = {}

function loadermeta:__call(...)
  return self.impl(...)
end

local function makeloader(loader_func, name)
  return setmetatable({ impl = loader_func, name = name }, loadermeta)
end

for i, loader in ipairs(package.loaders) do
  _M.loaders[i] = makeloader(loader, loader_names[i])
end

function meta:__call(name)
  return require(name)
end

return _M

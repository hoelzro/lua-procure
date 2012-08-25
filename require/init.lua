local meta = {}
local _M   = setmetatable({}, meta)

local function require(name)
  if package.loaded[name] == nil then
    local errors = { string.format("module '%s' not found", name) }
    local found

    for _, loader in ipairs(package.loaders) do
      local chunk = loader(name)

      if type(chunk) == 'function' then
        local result = chunk(name)
        found        = true

        if result == nil then
          result = true
        end

        if package.loaded[name] == nil then
          package.loaded[name] = result
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

function meta:__call(name)
  return require(name)
end

return _M

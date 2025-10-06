local helpers = {}

-- Extract subject from filename: get-countries.use-case.ts -> countries
helpers.extract_subject = function()
  local filename = vim.fn.expand("%:t") -- get current filename
  local subject = filename:match("get%-(.-)%.use%-case") or "Subject"
  return subject
end

-- Convert kebab-case to PascalCase
helpers.to_pascal_case = function(str)
  return str:gsub("(%-)(%l)", function(_, c) return c:upper() end):gsub("^%l", string.upper):gsub("%-", "")
end

-- Convert kebab-case to camelCase
helpers.to_camel_case = function(str)
  return str:gsub("(%-)(%l)", function(_, c) return c:upper() end):gsub("^%u", string.lower):gsub("%-", "")
end

return helpers

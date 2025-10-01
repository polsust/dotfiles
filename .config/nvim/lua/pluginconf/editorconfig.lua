require('editorconfig').properties.foo = function(bufnr, val)
  vim.b[bufnr].foo = val
end

function ToggleAutosave()
  vim.g.autosave = not vim.g.autosave
  if vim.g.autosave then
    print("Autosave enabled ✅")
  else
    print("Autosave disabled ❌")
  end
end

vim.cmd("command! AS lua ToggleAutosave()")

function ToggleCodeium()
  if vim.g.codeium_enabled == nil then
    vim.g.codeium_enabled = true
  end

  vim.g.codeium_enabled = not vim.g.codeium_enabled
  if vim.g.codeium_enabled then
    print("Codeium enabled ✅")
  else
    print("Codeium disabled ❌")
  end
end

vim.cmd("command! AI lua ToggleCodeium()")

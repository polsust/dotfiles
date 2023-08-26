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
  vim.g.codeium_enabled = not vim.g.codeium_enabled
  if vim.g.codeium_enabled then
    print("Codeium enabled ✅")
  else
    print("Codeium disabled ❌")
  end
end

vim.cmd("command! AI lua ToggleCodeium()")

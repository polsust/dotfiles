function ToggleAutosave()
  vim.g.autosave = not vim.g.autosave
  if vim.g.autosave then
    print("Autosave enabled ✅")
  else
    print("Autosave disabled ❌")
  end
end

vim.cmd("command! AS lua ToggleAutosave()")

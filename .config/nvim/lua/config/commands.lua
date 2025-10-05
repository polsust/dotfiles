function ToggleAutosave()
  vim.g.autosave = not vim.g.autosave
  if vim.g.autosave then
    print("Autosave enabled ✅")
  else
    print("Autosave disabled ❌")
  end
end

vim.cmd("command! AS lua ToggleAutosave()")

function ToggleAi()
  local ai_enabled = vim.cmd("Copilot status") == "Copilot: Ready"

  if ai_enabled then
    vim.cmd("Copilot disable")
    print("AI disabled ❌")
  else
    vim.cmd("Copilot enable")
    print("AI enabled ✅")
  end
end

vim.cmd("command! AI lua ToggleAi()")

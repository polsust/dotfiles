local dap_status_ok, dap = pcall(require, "dap")
if not dap_status_ok then
  return
end

local dap_ui_status_ok, dapui = pcall(require, "dapui")
if not dap_ui_status_ok then
  return
end

-- DapBreakpoint for breakpoints (default: B)
-- DapBreakpointCondition for conditional breakpoints (default: C)
-- DapLogPoint for log points (default: L)
-- DapStopped to indicate where the debugee is stopped (default: →)
-- DapBreakpointRejected to indicate breakpoints rejected by the debug adapter (default: R)

vim.cmd("hi DapSign guifg=#fa4848")
vim.fn.sign_define("DapBreakpoint", { text = "", texthl = "DapSign" })
vim.fn.sign_define("DapBreakpointCondition", { text = "", texthl = "DapSign" })
vim.fn.sign_define("DapLogPoint", { text = "", texthl = "DapSign" })
-- vim.fn.sign_define("DapStopped", { })
vim.fn.sign_define("DapBreakpointRejected", { text = "", texthl = "DapSign" })

dapui.setup()

vim.keymap.set("n", "<space>b", dap.toggle_breakpoint)

vim.keymap.set("n", "<space>lb", function()
  dap.set_breakpoint(vim.fn.input("Break point condition: "), nil, nil)
end)
vim.keymap.set("n", "<space>hb", function()
  dap.set_breakpoint(nil, vim.fn.input("Hit condition: "), nil)
end)
vim.keymap.set("n", "<Leader>ib", function()
  dap.set_breakpoint(nil, nil, vim.fn.input("Log point message: "))
end)

vim.keymap.set("n", "<space>gb", dap.run_to_cursor)

vim.keymap.set("n", "<space>pb", function()
  dapui.eval(nil, { enter = true })
end)

-- Down: Step over
-- Right: Step into
-- Left: Step out
-- Up: Restart frame

vim.keymap.set("n", "<F1>", dap.continue)

vim.keymap.set("n", "<F2>", dap.step_into)
vim.keymap.set("n", "<C-Right>", dap.step_into)

vim.keymap.set("n", "<F3>", dap.step_over)
vim.keymap.set("n", "<C-Down>", dap.step_over)

vim.keymap.set("n", "<F4>", dap.step_out)
vim.keymap.set("n", "<C-Left>", dap.step_out)

vim.keymap.set("n", "<F5>", dap.step_back)

vim.keymap.set("n", "<F12>", dap.restart)
vim.keymap.set("n", "<C-Up>", dap.restart)

dap.listeners.before.attach.dapui_config = function()
  dapui.open()
end

dap.listeners.before.launch.dapui_config = function()
  dapui.open()
end

dap.listeners.before.event_terminated.dapui_config = function()
  dapui.close()
end

dap.listeners.before.event_exited.dapui_config = function()
  dapui.close()
end

-- Adapters

dap.adapters.godot = {
  type = "server",
  host = "127.0.0.1",
  port = 6006,
}

dap.configurations.gdscript = {
  {
    type = "godot",
    request = "launch",
    name = "Launch scene",
    project = "${workspaceFolder}",
    launch_scene = true,
  },
}

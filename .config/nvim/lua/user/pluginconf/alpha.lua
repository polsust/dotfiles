local status_ok, alpha = pcall(require, "alpha")
if not status_ok then
	return
end

local dashboard = require("alpha.themes.dashboard")
dashboard.section.header.val = {
	[[███╗  ██╗██╗   ██╗██╗███╗   ███╗]],
	[[████╗ ██║██║   ██║██║████╗ ████║]],
	[[██╔██╗██║╚██╗ ██╔╝██║██╔████╔██║]],
	[[██║╚████║ ╚████╔╝ ██║██║╚██╔╝██║]],
	[[██║ ╚███║  ╚██╔╝  ██║██║ ╚═╝ ██║]],
	[[╚═╝  ╚══╝   ╚═╝   ╚═╝╚═╝     ╚═╝]],
}

dashboard.section.buttons.val = {
	dashboard.button("p", " " .. " Find project", ":lua require('telescope').extensions.projects.projects()<CR>"),
	dashboard.button("e", " " .. " New file", ":ene <BAR> startinsert <CR>"),
	dashboard.button("c", " " .. " Config", ":e ~/.config/nvim/ <CR>"),
	dashboard.button("q", " " .. " Quit", ":qa<CR>"),
}

alpha.setup(dashboard.opts)


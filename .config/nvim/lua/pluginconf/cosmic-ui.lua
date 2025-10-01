local status_ok, cosmic_ui = pcall(require, "cosmic-ui")
if not status_ok then
	return
end

cosmic_ui.setup()

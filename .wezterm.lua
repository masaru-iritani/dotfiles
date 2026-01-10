local wezterm = require("wezterm")
local config = wezterm.config_builder()

config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"
config.initial_cols = 120
config.initial_rows = 24
config.font_size = 16
config.font = wezterm.font_with_fallback({
	"UDEV Gothic 35NF",
	"Symbols Nerd Font Mono",
})

return config

local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window{}
	window:gui_window():toggle_fullscreen()
end)


config.term = "wezterm"
config.colors = {
	foreground = "#dcd7ba",
	background = "#000000",

	cursor_bg = "#c8c093",
	cursor_fg = "#c8c093",
	cursor_border = "#c8c093",

	selection_fg = "#c8c093",
	selection_bg = "#2d4f67",

	scrollbar_thumb = "#16161d",
	split = "#16161d",

	ansi = { "#090618", "#c34043", "#76946a", "#c0a36e", "#7e9cd8", "#957fb8", "#6a9589", "#c8c093" },
	brights = { "#727169", "#e82424", "#98bb6c", "#e6c384", "#7fb4ca", "#938aa9", "#7aa89f", "#dcd7ba" },
	indexed = { [16] = "#ffa066", [17] = "#ff5d62" },
}

config.foreground_text_hsb = {
	hue = 1.00,
	saturation = 1.00,
	brightness = 1.00
}
config.font = wezterm.font_with_fallback({
	"JetBrains Mono",
	"Hack Nerd Font Mono"
})
config.font_size = 16.5
config.force_reverse_video_cursor = true
config.window_padding = {
	left = 0,
	right = 0,
	top = 0,
	bottom = 0,
}
config.window_background_opacity = 0.8
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = true

config.background = {
	{
		source = {
			File = ""
		},
		height = "Cover",
		opacity = 0.2
	}
}

return config

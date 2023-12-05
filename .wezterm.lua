local wezterm = require 'wezterm'

local config = {}

if wezterm.config_builder then
	config = wezterm.config_builder()
end

wezterm.on("gui-startup", function()
	local _, _, window = wezterm.mux.spawn_window{}
	window:gui_window():maximize()
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

local function monaspace(name)
	return {
		family = "Monaspace " .. name,
		harfbuzz_features = { 'ss01=1', 'ss02=1', 'ss03=1', 'ss04=1', 'ss05=1', 'ss06=1', 'ss07=1', 'ss08=1', 'calt=1', 'dlig' }
	}
end

config.font = wezterm.font_with_fallback({
	"JetBrainsMono NFM",
	"Hack Nerd Font Mono",
	(monaspace "Neon"),
	(monaspace "Argon"),
	(monaspace "Xenon"),
	(monaspace "Radon"),
	(monaspace "Krypton"),
})
config.font_size = 14
config.force_reverse_video_cursor = true
config.window_padding = {
	left = "3px",
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
		-- attachment = "Scroll",
		height = "Cover",
		hsb = {
			hue = 1.0,
			saturation = 1.0,
			brightness = 0.05,
		}
	}
}

return config

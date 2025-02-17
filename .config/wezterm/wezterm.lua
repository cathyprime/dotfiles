local wezterm = require("wezterm")
local colors = require("colors")

local config = {}

if wezterm.config_builder then
    config = wezterm.config_builder()
end

wezterm.on("gui-startup", function()
    local _, _, window = wezterm.mux.spawn_window{}
    window:gui_window():maximize()
    window:gui_window():toggle_fullscreen()
end)

config.disable_default_key_bindings = true
config.leader = { key = "b", mods = "CTRL" }
config.enable_kitty_keyboard = true
config.term = "wezterm"
config.colors = colors

config.foreground_text_hsb = {
    hue = 1.00,
    saturation = 1.00,
    brightness = 1.00
}

local function monaspace(name)
    return {
        family = "Monaspace " .. name,
        harfbuzz_features = { "ss01=1", "ss02=1", "ss03=1", "ss04=1", "ss05=1", "ss06=1", "ss07=1", "ss08=1", "calt=1", "dlig" }
    }
end

config.default_cursor_style = "SteadyBlock"
config.cursor_blink_rate = 1000
config.cursor_blink_ease_in = "Constant"
config.cursor_blink_ease_out = "Constant"

config.font = wezterm.font_with_fallback({
    "Iosevka",
    "JetBrainsMono NF",
    "Noto emoji",
    "Hack Nerd Font Mono",
    (monaspace "Neon"),
    (monaspace "Argon"),
    (monaspace "Xenon"),
    (monaspace "Radon"),
    (monaspace "Krypton"),
})

if wezterm.hostname() == "luna" then
    -- config.font_size = 14.8 -- JetBrainsMono NF
    config.font_size = 14.3 -- IosevkaCustom
    -- config.font_size = 13.1
elseif wezterm.hostname() == "juno" then
    -- config.font_size = 16.8 -- JetBrainsMono NF
    config.font_size = 17.7 -- IosevkaCustom
else
    config.font_size = 14
end

config.force_reverse_video_cursor = false
config.window_padding = {
    left = 0,
    right = 0,
    top = 0,
    bottom = 0,
}
config.window_decorations = "RESIZE"
config.hide_tab_bar_if_only_one_tab = false
config.hide_mouse_cursor_when_typing = true
config.use_fancy_tab_bar = false
config.tab_bar_at_bottom = false

local ok_w, w = pcall(require, "wallpaper")
if ok_w then
    config.background = w
end

local ok_k, k = pcall(require, "keymaps")
if ok_k then
    config.keys = k
end

pcall(require, "tabbar")
pcall(require, "zenmode")

return config

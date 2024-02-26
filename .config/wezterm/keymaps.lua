local wezterm = require("wezterm")
local workspace = require("workspace")
local act = wezterm.action

local function switch_create_tab(i)
    return function(win, pane)
        local tab = win:mux_window():tabs_with_info()[i]
        wezterm.log_info(tab)
        if tab == nil then
            win:mux_window():spawn_tab({})
        end
        win:perform_action(wezterm.action.ActivateTab(i - 1), pane)
    end
end

local keys = {
    {
        key = "c",
        mods = "CTRL|SHIFT",
        action = act.CopyTo("ClipboardAndPrimarySelection")
    },
    {
        key = "v",
        mods = "CTRL|SHIFT",
        action = act.PasteFrom("Clipboard")
    },
    {
        key = "=",
        mods = "CTRL",
        action = act.IncreaseFontSize
    },
    {
        key = "-",
        mods = "CTRL",
        action = act.DecreaseFontSize
    },
    {
        key = "0",
        mods = "CTRL",
        action = act.ResetFontSize
    },
    {
        key = "p",
        mods = "CTRL|SHIFT",
        action = act.ActivateCommandPalette,
    },
    {
        key = "p",
        mods = "LEADER",
        action = act.ActivateCommandPalette,
    },
    {
        key = "v",
        mods = "LEADER",
        action = act.ActivateCopyMode
    },
    {
        key = "f",
        mods = "LEADER",
        action = workspace.switch_workspace(),
    },
    {
        key = "s",
        mods = "LEADER",
        action = act.ShowLauncherArgs({ flags = "FUZZY|WORKSPACES" }),
    },
    {
        key = "b",
        mods = "LEADER|CTRL",
        action = act.ActivateTab(0)
    },
    {
        key = 'j',
        mods = 'LEADER|CTRL',
        action = wezterm.action_callback(switch_create_tab(2)),
    },
    {
        key = "k",
        mods = "LEADER|CTRL",
        action = wezterm.action_callback(switch_create_tab(3))
    },
    {
        key = "n",
        mods = "LEADER|CTRL",
        action = act.SpawnTab("CurrentPaneDomain")
    },
    {
        key = "%",
        mods = "LEADER|SHIFT",
        action = act.SplitHorizontal({ domain = "CurrentPaneDomain" })
    },
    {
        key = '"',
        mods = "LEADER|SHIFT",
        action = act.SplitVertical({ domain = "CurrentPaneDomain" })
    },
    {
        key = "q",
        mods = "LEADER|CTRL",
        action = act.QuitApplication,
    },
    {
        key = ",",
        mods = "LEADER|CTRL",
        action = act.MoveTabRelative(-1),
    },
    {
        key = ".",
        mods = "LEADER|CTRL",
        action = act.MoveTabRelative(1),
    },
    {
        key = "q",
        mods = "LEADER",
        action = act.CloseCurrentTab({ confirm = false })
    },
}

for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = "LEADER",
        action = wezterm.action_callback(switch_create_tab(i))
    })
end

for i = 1, 9 do
    table.insert(keys, {
        key = tostring(i),
        mods = "LEADER|SHIFT",
        action = act.MoveTab(i - 1)
    })
end

return keys

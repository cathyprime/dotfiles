local wezterm = require("wezterm")
local colors = require("colors")
local SOLID_LEFT_ARROW = wezterm.nerdfonts.pl_right_hard_divider
local SOLID_RIGHT_ARROW = wezterm.nerdfonts.pl_left_hard_divider

local function tab_title(tab_info)
    local title = tab_info.tab_title
    -- if the tab title is explicitly set, take that
    if title and #title > 0 then
        return title
    end
    -- Otherwise, use the title from the active pane
    -- in that tab
    return tab_info.tab_index + 1 .. ": " .. tab_info.active_pane.title
end

wezterm.on(
    "format-tab-title",
    -- tab, tabs, panes, config, hover, max_width
    function(tab, _, _, _, hover, max_width)
        local background = colors.ansi[2]
        local foreground = colors.foreground

        if hover then
            background = "#3c1361"
            foreground = colors.selection_fg
        elseif tab.is_active then
            background = colors.ansi[3]
        end

        local title = tab_title(tab)
        title = wezterm.truncate_right(title, max_width - 2)

        return {
            { Background = { Color = background } },
            { Foreground = { Color = foreground } },
            { Text = " " .. title .. " " },
        }
    end
)

wezterm.on("update-right-status", function(window, pane)
    local cells = {}
    local cwd_uri = pane:get_current_working_dir()
    if cwd_uri then
        local hostname = ""

        if type(cwd_uri) == "userdata" then
            hostname = cwd_uri["host"] or wezterm.hostname()
        else
            cwd_uri = cwd_uri:sub(8)
            local slash = cwd_uri:find "/"
            if slash then
                hostname = cwd_uri:sub(1, slash - 1)
            end
        end

        local dot = hostname:find "[.]"
        if dot then
            hostname = hostname:sub(1, dot - 1)
        end
        if hostname == "" then
            hostname = wezterm.hostname()
        end

        table.insert(cells, wezterm.mux.get_active_workspace())
        table.insert(cells, "active ws: " .. #wezterm.mux.get_workspace_names())
        table.insert(cells, hostname)
    end

    local date = wezterm.strftime "%H:%M"
    table.insert(cells, date)

    for _, b in ipairs(wezterm.battery_info()) do
        local icon = ""
        local charge = b.state_of_charge * 100
        if charge >= 90 then
            icon = " "
        elseif charge >= 60 then
            icon = " "
        elseif charge >= 30 then
            icon = " "
        elseif charge >= 10 then
            icon = " "
        else
            icon = " "
        end
        table.insert(cells, 1, string.format("%s %.0f%%", icon, charge))
    end

    local cell_colors = {
        "#3c1361",
        "#52307c",
        "#663a82",
        "#7c5295",
        "#b491c8",
    }

    local text_fg = colors.foreground
    local elements = {}
    table.insert(elements, { Foreground = { Color = cell_colors[1] } })
    table.insert(elements, { Background = { Color = "#16161d" } })
    table.insert(elements, { Text = SOLID_LEFT_ARROW })
    local num_cells = 0

    local function push(text, is_last)
        local cell_no = num_cells + 1
        table.insert(elements, { Foreground = { Color = text_fg } })
        table.insert(elements, { Background = { Color = cell_colors[cell_no] } })
        table.insert(elements, { Text = " " .. text .. " " })
        if not is_last then
            table.insert(elements, { Foreground = { Color = cell_colors[cell_no + 1] } })
            table.insert(elements, { Text = SOLID_LEFT_ARROW })
        end
        num_cells = num_cells + 1
    end

    while #cells > 0 do
        local cell = table.remove(cells, 1)
        push(cell, #cells == 0)
    end

    window:set_right_status(wezterm.format(elements))
end)

local wezterm = require("wezterm")
local act = wezterm.action

-- Equivalent to POSIX basename(3) Given "/foo/bar" returns "bar"
-- Given "c:\\foo\\bar" returns "bar"
local function basename(s)
	return string.gsub(s, "(.*[/\\])(.*)", "%2")
end

local SOLID_LEFT_ARROW = utf8.char(0xe0ba)
local SOLID_LEFT_MOST = utf8.char(0x2588)
local SOLID_RIGHT_ARROW = utf8.char(0xe0bc)

local ADMIN_ICON = utf8.char(0xf49c)

local CMD_ICON = utf8.char(0xe62a)
local NU_ICON = utf8.char(0xe7a8)
local PS_ICON = utf8.char(0xe70f)
local ELV_ICON = utf8.char(0xfc6f)
local WSL_ICON = utf8.char(0xf83c)
local YORI_ICON = utf8.char(0xf1d4)
local NYA_ICON = utf8.char(0xf61a)

local VIM_ICON = utf8.char(0xe62b)
local PAGER_ICON = utf8.char(0xf718)
local FUZZY_ICON = utf8.char(0xf0b0)
local HOURGLASS_ICON = utf8.char(0xf252)
local SUNGLASS_ICON = utf8.char(0xf9df)

local PYTHON_ICON = utf8.char(0xf820)
local NODE_ICON = utf8.char(0xe74e)
local DENO_ICON = utf8.char(0xe628)
local LAMBDA_ICON = utf8.char(0xfb26)

local SUP_IDX = {
	"¹",
	"²",
	"³",
	"⁴",
	"⁵",
	"⁶",
	"⁷",
	"⁸",
	"⁹",
	"¹⁰",
	"¹¹",
	"¹²",
	"¹³",
	"¹⁴",
	"¹⁵",
	"¹⁶",
	"¹⁷",
	"¹⁸",
	"¹⁹",
	"²⁰",
}
local SUB_IDX = {
	"₁",
	"₂",
	"₃",
	"₄",
	"₅",
	"₆",
	"₇",
	"₈",
	"₉",
	"₁₀",
	"₁₁",
	"₁₂",
	"₁₃",
	"₁₄",
	"₁₅",
	"₁₆",
	"₁₇",
	"₁₈",
	"₁₉",
	"₂₀",
}

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local edge_background = "#121212"
	local background = "#4E4E4E"
	local foreground = "#1C1B19"
	local dim_foreground = "#3A3A3A"

	if tab.is_active then
		background = "#eff1f5"
		foreground = "#1C1B19"
	elseif hover then
		background = "#bcc0cc"
		foreground = "#1C1B19"
	end

	local edge_foreground = background
	local process_name = tab.active_pane.foreground_process_name
	local pane_title = tab.active_pane.title
	local exec_name = basename(process_name):gsub("%.exe$", "")
	local title_with_icon

	if exec_name == "nu" then
		title_with_icon = NU_ICON .. " NuShell"
	elseif exec_name == "pwsh" then
		title_with_icon = PS_ICON .. " PS"
	elseif exec_name == "cmd" then
		title_with_icon = CMD_ICON .. " CMD"
	elseif exec_name == "elvish" then
		title_with_icon = ELV_ICON .. " Elvish"
	elseif exec_name == "wsl" or exec_name == "wslhost" then
		title_with_icon = WSL_ICON .. " WSL"
	elseif exec_name == "nyagos" then
		title_with_icon = NYA_ICON .. " " .. pane_title:gsub(".*: (.+) %- .+", "%1")
	elseif exec_name == "yori" then
		title_with_icon = YORI_ICON .. " " .. pane_title:gsub(" %- Yori", "")
	elseif exec_name == "nvim" then
		title_with_icon = VIM_ICON .. " " .. pane_title:gsub("^(%S+)%s+(%d+/%d+) %- nvim", " %2 %1")
	elseif exec_name == "bat" or exec_name == "less" or exec_name == "moar" then
		title_with_icon = PAGER_ICON .. " " .. exec_name:upper()
	elseif exec_name == "fzf" or exec_name == "hs" or exec_name == "peco" then
		title_with_icon = FUZZY_ICON .. " " .. exec_name:upper()
	elseif exec_name == "btm" or exec_name == "ntop" then
		title_with_icon = SUNGLASS_ICON .. " " .. exec_name:upper()
	elseif exec_name == "ranger" then
		title_with_icon = ""
	elseif exec_name == "python" or exec_name == "hiss" then
		title_with_icon = PYTHON_ICON .. " " .. exec_name
	elseif exec_name == "node" then
		title_with_icon = NODE_ICON .. " " .. exec_name:upper()
	elseif exec_name == "deno" then
		title_with_icon = DENO_ICON .. " " .. exec_name:upper()
	elseif exec_name == "bb" or exec_name == "cmd-clj" or exec_name == "janet" or exec_name == "hy" then
		title_with_icon = LAMBDA_ICON .. " " .. exec_name:gsub("bb", "Babashka"):gsub("cmd%-clj", "Clojure")
	else
		title_with_icon = HOURGLASS_ICON .. " " .. exec_name
	end
	if pane_title:match("^Administrator: ") then
		title_with_icon = title_with_icon .. " " .. ADMIN_ICON
	end
	local left_arrow = SOLID_LEFT_ARROW
	if tab.tab_index == 0 then
		left_arrow = SOLID_LEFT_MOST
	end
	local id = SUB_IDX[tab.tab_index + 1]
	local pid = SUP_IDX[tab.active_pane.pane_index + 1]
	local title = " " .. title_with_icon .. " "

	return {
		{ Attribute = { Intensity = "Bold" } },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = left_arrow },
		{ Background = { Color = background } },
		{ Foreground = { Color = foreground } },
		{ Text = id },
		{ Text = title },
		{ Foreground = { Color = dim_foreground } },
		-- { Text = pid },
		{ Background = { Color = edge_background } },
		{ Foreground = { Color = edge_foreground } },
		{ Text = SOLID_RIGHT_ARROW },
		{ Attribute = { Intensity = "Normal" } },
	}
end)

function get_font_size()
	function os.capture(cmd, raw)
		local f = assert(io.popen(cmd, "r"))
		local s = assert(f:read("*a"))
		f:close()
		if raw then
			return s
		end
		s = string.gsub(s, "^%s+", "")
		s = string.gsub(s, "%s+$", "")
		s = string.gsub(s, "[\n\r]+", " ")
		return s
	end

	local display_type =
		os.capture("system_profiler SPDisplaysDataType | grep -B 3 'Main Display:' | awk '/Display Type/ {print $3}'")

	local font_size = 11

	if display_type == "Built-in" then
		print("Changing font be bigger", display_type)
		font_size = 22
	else
		print("Changing font be smaller", display_type)
		font_size = 11
	end
	return font_size
end

return {
	font_dirs = { "fonts" },
	font_size = get_font_size(),
	dpi = 96.0,
	freetype_load_target = "Normal",
	font = wezterm.font_with_fallback({
		-- "Cartograph CF Demi Bold",
		"Jetbrains Mono NL",
		"Fira Code Nerd Font Mono",
	}),

	tab_max_width = 100,
	enable_scroll_bar = false,
	use_fancy_tab_bar = false,
	window_background_opacity = 0.94,
	window_padding = {
		left = 0,
		right = 0,
		top = 0,
		bottom = 0,
	},
	window_frame = {
		font_size = 12.0,
		border_left_width = 0,
		border_right_width = 0,
		border_bottom_height = 0,
		border_top_height = 0,
	},

	set_environment_variables = {
		LANG = "en_US.UTF-8",
		PATH = wezterm.executable_dir .. ";" .. os.getenv("PATH"),
	},
	color_scheme = "Catppuccin Mocha",
	max_fps = 144,
	window_decorations = "RESIZE",
	tab_bar_at_bottom = true,
	colors = {
		tab_bar = {
			background = "#121212",
			new_tab = { bg_color = "#121212", fg_color = "#121212", intensity = "Bold" },
			new_tab_hover = { bg_color = "#121212", fg_color = "#121212", intensity = "Bold" },
			active_tab = { bg_color = "#121212", fg_color = "#eff1f5" },
		},
	},
	inactive_pane_hsb = {
		saturation = 0.9,
		brightness = 0.8,
	},
	line_height = 1.15,
	visual_bell = {
		fade_in_duration_ms = 75,
		fade_out_duration_ms = 75,
		target = "CursorColor",
	},
	-- disable_default_key_bindings = true,
	leader = { key = "`" },
	keys = {
		{
			key = "l",
			mods = "CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "l" }),
			}),
		},
		{
			key = "h",
			mods = "CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "h" }),
			}),
		},
		{
			key = "j",
			mods = "CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "j" }),
			}),
		},
		{
			key = "k",
			mods = "CMD",
			action = wezterm.action.Multiple({
				wezterm.action.SendKey({ key = "w", mods = "CTRL" }),
				wezterm.action.SendKey({ key = "k" }),
			}),
		},
		-- { key = "raw:36", mods = "SHIFT", action = wezterm.action({ SendString = "\033[\015;2u" }) },
		{ key = "Tab", mods = "CTRL", action = act({ ActivateTabRelative = 1 }) },
		{ key = "Tab", mods = "CTRL|SHIFT", action = act({ ActivateTabRelative = -1 }) },
		{ key = "Enter", mods = "ALT", action = "ToggleFullScreen" },
		{ key = "Insert", mods = "SHIFT", action = act({ PasteFrom = "PrimarySelection" }) },
		{ key = "Insert", mods = "CTRL", action = act({ CopyTo = "PrimarySelection" }) },
		{ key = "l", mods = "OPT", action = act.SendKey({ key = "l", mods = "CMD" }) },
		{ key = "v", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "s", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "|", mods = "LEADER", action = act({ SplitHorizontal = { domain = "CurrentPaneDomain" } }) },
		{ key = "-", mods = "LEADER", action = act({ SplitVertical = { domain = "CurrentPaneDomain" } }) },
		{ key = "h", mods = "LEADER", action = act({ ActivatePaneDirection = "Left" }) },
		{ key = "l", mods = "LEADER", action = act({ ActivatePaneDirection = "Right" }) },
		{ key = "j", mods = "LEADER", action = act({ ActivatePaneDirection = "Down" }) },
		{ key = "k", mods = "LEADER", action = act({ ActivatePaneDirection = "Up" }) },
		{ key = "z", mods = "LEADER", action = "TogglePaneZoomState" },
		{ key = "q", mods = "LEADER", action = "QuickSelect" },
		{ key = "/", mods = "LEADER", action = act({ Search = { CaseInSensitiveString = "" } }) },
		{ key = "1", mods = "LEADER", action = act({ ActivateTab = 0 }) },
		{ key = "2", mods = "LEADER", action = act({ ActivateTab = 1 }) },
		{ key = "3", mods = "LEADER", action = act({ ActivateTab = 2 }) },
		{ key = "4", mods = "LEADER", action = act({ ActivateTab = 3 }) },
		{ key = "5", mods = "LEADER", action = act({ ActivateTab = 4 }) },
		{ key = "6", mods = "LEADER", action = act({ ActivateTab = 5 }) },
		{ key = "7", mods = "LEADER", action = act({ ActivateTab = 6 }) },
		{ key = "8", mods = "LEADER", action = act({ ActivateTab = 7 }) },
		{ key = "9", mods = "LEADER", action = act({ ActivateTab = 8 }) },
		{ key = "o", mods = "LEADER", action = "ActivateLastTab" },
		{ key = "g", mods = "LEADER", action = "ShowTabNavigator" },
		{ key = "c", mods = "LEADER", action = "ShowLauncher" },
		{ key = "r", mods = "LEADER", action = "ReloadConfiguration" },
		{ key = "x", mods = "LEADER", action = act({ CloseCurrentPane = { confirm = true } }) },
		{ key = "x", mods = "LEADER|SHIFT", action = act({ CloseCurrentTab = { confirm = true } }) },
		{ key = "`", mods = "LEADER", action = act({ SendString = "`" }) },
	},
}

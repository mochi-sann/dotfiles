local wezterm = require("wezterm")

wezterm.on("user-var-changed", function(window, pane, name, value)
	local overrides = window:get_config_overrides() or {}
	if name == "ZEN_MODE" then
		local incremental = value:find("+")
		local number_value = tonumber(value)
		if incremental ~= nil then
			while number_value > 0 do
				window:perform_action(wezterm.action.IncreaseFontSize, pane)
				number_value = number_value - 1
			end
			overrides.enable_tab_bar = false
		elseif number_value < 0 then
			window:perform_action(wezterm.action.ResetFontSize, pane)
			overrides.font_size = nil
			overrides.enable_tab_bar = true
		else
			overrides.font_size = number_value
			overrides.enable_tab_bar = false
		end
	end
	window:set_config_overrides(overrides)
end)

-- wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
--   local title = wezterm.truncate_right(utils.basename(tab.active_pane.foreground_process_name), max_width)
--   if title == "" then
--     title = wezterm.truncate_right(
--       utils.basename(utils.convert_home_dir(tab.active_pane.current_working_dir)),
--       max_width
--     )
--   end
--   return {
--     { Text = tab.tab_index + 1 .. ":" .. title },
--   }
-- end)

wezterm.on("format-tab-title", function(tab, tabs, panes, config, hover, max_width)
	local tab_index = tab.tab_index + 1

	-- Copymode時のみ、"Copymode..."というテキストを表示
	if tab.is_active and string.match(tab.active_pane.title, "Copy mode:") ~= nil then
		return string.format(" %d %s ", tab_index, "Copy mode...")
	end

	return string.format(" %d ", tab_index)
end)
--
-- (曜日, 1–7, 日曜日が 1)
local function day_of_week_ja(w_num)
	if w_num == 1 then
		return "日"
	elseif w_num == 2 then
		return "月"
	elseif w_num == 3 then
		return "火"
	elseif w_num == 4 then
		return "水"
	elseif w_num == 5 then
		return "木"
	elseif w_num == 6 then
		return "金"
	elseif w_num == 7 then
		return "土"
	end
end

wezterm.on("update-status", function(window, pane)
	-- 日付のtableを作成する方法じゃないと曜日の取得がうまくいかなかった
	-- NOTE: https://www.lua.org/pil/22.1.html
	local wday = os.date("*t").wday
	-- 指定子の後に半角スペースをつけないと正常に表示されなかった
	local wday_ja = string.format("(%s)", day_of_week_ja(wday))
	local date = wezterm.strftime("  %Y-%m-%d " .. wday_ja .. "   %H:%M:%S")

	local bat = ""

	for _, b in ipairs(wezterm.battery_info()) do
		local battery_state_of_charge = b.state_of_charge * 100
		local battery_icon = "ﮣ "

		if battery_state_of_charge >= 95 then
			battery_icon = "󰁹"
		elseif battery_state_of_charge >= 90 then
			battery_icon = "󰂂"
		elseif battery_state_of_charge >= 80 then
			battery_icon = "󰂁"
		elseif battery_state_of_charge >= 70 then
			battery_icon = "󰂀"
		elseif battery_state_of_charge >= 60 then
			battery_icon = "󰁿"
		elseif battery_state_of_charge >= 50 then
			battery_icon = "󰁾"
		elseif battery_state_of_charge >= 40 then
			battery_icon = "󰁽"
		elseif battery_state_of_charge >= 30 then
			battery_icon = "󰁼"
		elseif battery_state_of_charge >= 20 then
			battery_icon = "󰁻"
		elseif battery_state_of_charge >= 10 then
			battery_icon = "󰁺"
		else
			battery_icon = "󰁺  "
		end
		if b.state == "Charging" then
			battery_icon = battery_icon .. "ﮣ "
		else
			battery_icon = battery_icon .. " "
		end

		bat = string.format("%s%.0f%% ", battery_icon, battery_state_of_charge)
	end

	window:set_right_status(wezterm.format({
		{ Text = date .. "  " .. bat },
	}))
end)
-- タブの表示をカスタマイズ

local base_colors = {
	dark = "#172331",
	yellow = "#ffe64d",
}

return {
	use_ime = true,
	font_size = 14,
	-- window_background_opacity = 0.90,
	window_decorations = "RESIZE",
	-- font_sizeasdf = 14,
	-- font = wezterm.font("UDEV Gothic 35NFLG"),
	-- font = wezterm.font("Monocraft"),
	-- font  = wezterm.font("PlemolJP35 Console"),

	-- font = wezterm.font("HackGen35Nerd Console"),
	-- font = wezterm.font("UDEV Gothic 35LG", {weight="Regular", stretch="Normal", style="Normal"}) ,-- => /Users/mochi/Library/Fonts/UDEVGothic35LG-Regular.ttf, CoreText
	-- font = wezterm.font("JetBrainMono Nerd Font", {weight="Regular", stretch="Normal", italic=false}),
	-- font = wezterm.font("SF Mono Square", {weight="Regular", stretch="Normal", style=Normal}),
	-- font = wezterm.font_with_fallback({
	--   -- "JetBrainsMono",
	--   "SF Mono Square",
	-- }),
	-- font = wezterm.font("Cica", {weight="Regular", stretch="Normal", style=Normal}),
	-- =>
	-- font = wezterm.font("UDEVGothicLG Nerd Font", {weight="Regular", stretch="Normal", style=Normal}),
	window_close_confirmation = "NeverPrompt",
	use_fancy_tab_bar = false,
	tab_max_width = 50,
	-- line_height = 1.01,
	scrollback_lines = 5000,
	enable_scroll_bar = false,
	warn_about_missing_glyphs = false,
	window_padding = {
		left = "0cell",
		right = "0cell",
		top = "0cell",
		bottom = "0cell",
	},
	-- color_scheme = "iceberg-dark",
	color_scheme = "tokyonight",
	-- window_background_opacity = 0.94,
	adjust_window_size_when_changing_font_size = false,
	hyperlink_rules = {
		-- Linkify things that look like URLs
		-- This is actually the default if you don't specify any hyperlink_rules
		{
			regex = "\\b\\w+://(?:[\\w.-]+)\\.[a-z]{2,15}\\S*\\b",
			format = "$0",
		},

		-- linkify email addresses
		{
			regex = "\\b\\w+@[\\w-]+(\\.[\\w-]+)+\\b",
			format = "mailto:$0",
		},

		-- file:// URI
		{
			regex = "\\bfile://\\S*\\b",
			format = "$0",
		},

		-- Make task numbers clickable
		--[[
    {
      regex = "\\b[tT](\\d+)\\b"
      format = "https://example.com/tasks/?t=$1"
    }
    ]]
	},
}

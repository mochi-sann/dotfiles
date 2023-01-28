local wezterm = require("wezterm")
--
function scheme_for_appearance(appearance)
	if appearance:find("Dark") then
		-- return "Dracula (Official)"
		return "tokyonight"
	else
		return "tokyonight"
	end
end

wezterm.on("window-config-reloaded", function(window, pane)
	local overrides = window:get_config_overrides() or {}
	local appearance = window:get_appearance()
	local scheme = scheme_for_appearance(appearance)
	if overrides.color_scheme ~= scheme then
		overrides.color_scheme = scheme
		window:set_config_overrides(overrides)
	end
end)

return {
	use_ime = true,
	font_size = 15,
	window_background_opacity = 1,

	-- font_sizeasdf = 14,
	font = wezterm.font("UDEV Gothic 35LG"),
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
	use_fancy_tab_bar = false,
	tab_max_width = 50,
	-- line_height = 1.01,
	scrollback_lines = 5000,
	enable_scroll_bar = false,
	window_padding = {
		left = "0cell",
		right = "0cell",
		top = "0cell",
		bottom = "0cell",
	},
	-- color_scheme = "iceberg-dark",
	color_scheme = "tokyonight",

	-- colors = {
	-- 	-- The default text color
	-- 	foreground = "#f8f8f2",
	-- 	-- The default background color
	-- 	background = "#282a36",
	--
	-- 	-- Overrides the cell background color when the current cell is occupied by the
	-- 	-- cursor and the cursor style is set to Block
	-- 	cursor_bg = "#f8f8f2",
	-- 	-- Overrides the text color when the current cell is occupied by the cursor
	-- 	cursor_fg = "#1d1920",
	-- 	-- Specifies the border color of the cursor when the cursor style is set to Block,
	-- 	-- or the color of the vertical or horizontal bar when the cursor style is set to
	-- 	-- Bar or Underline.
	-- 	cursor_border = "#f8f8f2",
	--
	-- 	-- the foreground color of selected text
	-- 	selection_fg = "none",
	-- 	-- the background color of selected text
	-- 	selection_bg = "rgba(68,71,90,0.5)",
	--
	-- 	-- The color of the scrollbar "thumb"; the portion that represents the current viewport
	-- 	scrollbar_thumb = "#44475a",
	--
	-- 	-- The color of the split lines between panes
	-- 	split = "#6272a4",
	--
	-- 	ansi = { "#21222C", "#FF5555", "#50FA7B", "#F1FA8C", "#BD93F9", "#FF79C6", "#8BE9FD", "#F8F8F2" },
	-- 	brights = { "#6272A4", "#FF6E6E", "#69FF94", "#FFFFA5", "#D6ACFF", "#FF92DF", "#A4FFFF", "#FFFFFF" },
	--
	-- 	-- Arbitrary colors of the palette in the range from 16 to 255
	-- 	indexed = {
	-- 		[136] = "#44475A",
	-- 	},
	--
	-- 	-- Since: nightly builds only
	-- 	-- When the IME, a dead key or a leader key are being processed and are effectively
	-- 	-- holding input pending the result of input composition, change the cursor
	-- 	-- to this color to give a visual cue about the compose state.
	-- 	-- compose_cursor = "#FFB86C",
	--
	-- 	tab_bar = {
	-- 		-- The color of the strip that goes along the top of the window
	-- 		-- (does not apply when fancy tab bar is in use)
	-- 		background = "#282a36",
	--
	-- 		-- The active tab is the one that has focus in the window
	-- 		active_tab = {
	-- 			-- The color of the background area for the tab
	-- 			bg_color = "#bd93f9",
	-- 			-- The color of the text for the tab
	-- 			fg_color = "#282a36",
	--
	-- 			-- Specify whether you want "Half", "Normal" or "Bold" intensity for the
	-- 			-- label shown for this tab.
	-- 			-- The default is "Normal"
	-- 			intensity = "Normal",
	--
	-- 			-- Specify whether you want "None", "Single" or "Double" underline for
	-- 			-- label shown for this tab.
	-- 			-- The default is "None"
	-- 			underline = "None",
	--
	-- 			-- Specify whether you want the text to be italic (true) or not (false)
	-- 			-- for this tab.  The default is false.
	-- 			italic = false,
	--
	-- 			-- Specify whether you want the text to be rendered with strikethrough (true)
	-- 			-- or not for this tab.  The default is false.
	-- 			strikethrough = false,
	-- 		},
	--
	-- 		-- Inactive tabs are the tabs that do not have focus
	-- 		inactive_tab = {
	-- 			bg_color = "#282a36",
	-- 			fg_color = "#f8f8f2",
	--
	-- 			-- The same options that were listed under the `active_tab` section above
	-- 			-- can also be used for `inactive_tab`.
	-- 		},
	--
	-- 		-- You can configure some alternate styling when the mouse pointer
	-- 		-- moves over inactive tabs
	-- 		inactive_tab_hover = {
	-- 			bg_color = "#6272a4",
	-- 			fg_color = "#f8f8f2",
	-- 			italic = true,
	--
	-- 			-- The same options that were listed under the `active_tab` section above
	-- 			-- can also be used for `inactive_tab_hover`.
	-- 		},
	--
	-- 		-- The new tab button that let you create new tabs
	-- 		new_tab = {
	-- 			bg_color = "#282a36",
	-- 			fg_color = "#f8f8f2",
	--
	-- 			-- The same options that were listed under the `active_tab` section above
	-- 			-- can also be used for `new_tab`.
	-- 		},
	--
	-- 		-- You can configure some alternate styling when the mouse pointer
	-- 		-- moves over the new tab button
	-- 		new_tab_hover = {
	-- 			bg_color = "#ff79c6",
	-- 			fg_color = "#f8f8f2",
	-- 			italic = true,
	--
	-- 			-- The same options that were listed under the `active_tab` section above
	-- 			-- can also be used for `new_tab_hover`.
	-- 		},
	-- 	},
	-- },
	-- , {
	--   cursor_fg = "#f00000",
	--
	--   tab_bar = {
	--     -- The color of the strip that goes along the top of the window
	--     -- (does not apply when fancy tab bar is in use)
	--     background = "#000000",
	--
	--     -- The active tab is the one that has focus in the window
	--     active_tab = {
	--       -- The color of the background area for the tab
	--       bg_color = "#222222",
	--       -- The color of the text for the tab
	--       fg_color = "#f5f5f5",
	--
	--       -- Specify whether you want "Half", "Normal" or "Bold" intensity for the
	--       -- label shown for this tab.
	--       -- The default is "Normal"
	--       -- intensity = "Normal",
	--
	--       -- Specify whether you want "None", "Single" or "Double" underline for
	--       -- label shown for this tab.
	--       -- The default is "None"
	--       -- underline = "Single",
	--
	--       -- Specify whether you want the text to be italic (true) or not (false)
	--       -- for this tab.  The default is false.
	--
	--       -- Specify whether you want the text to be rendered with strikethrough (true)
	--       -- or not for this tab.  The default is false.
	--       strikethrough = false,
	--     },
	--
	--     -- Inactive tabs are the tabs that do not have focus
	--   }
	-- },

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

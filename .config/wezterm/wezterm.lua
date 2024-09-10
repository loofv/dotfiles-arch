local wezterm = require('wezterm')
local act = wezterm.action;

return {
	-- For example, changing the color scheme:
	color_scheme = 'noir',
	front_end = 'WebGpu',
	max_fps = 144,
	window_background_opacity = 0.5,
	font_size = 20,
	hide_tab_bar_if_only_one_tab = true,
	use_fancy_tab_bar = true,
	window_decorations = "RESIZE"
}

-- Pull in the wezterm API
local wezterm = require('wezterm')

-- This will hold the configuration.
-- local config = wezterm.config_builder()

-- This is where you actually apply your config choices
local act = wezterm.action;

return {

	-- For example, changing the color scheme:
	color_scheme = 'noir',
	front_end = 'WebGpu',
	max_fps = 144,
	window_background_opacity = 0.8
}

--------------------------------------------------------------------------------------
-- --- Pull in the wezterm API
-- local wezterm = require 'wezterm'
--
-- -- This will hold the configuration.
-- local config = wezterm.config_builder()
--
-- -- This is where you actually apply your config choices
--
-- -- For example, changing the color scheme:
-- config.color_scheme = 'C64'
--
-- -- and finally, return the configuration to wezterm
-- return config

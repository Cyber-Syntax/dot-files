local awful = require("awful")
local gears = require("gears")
local client_keys = require("configuration.client.keys")
local client_buttons = require("configuration.client.buttons")

-- Rules
awful.rules.rules = {
	-- All clients will match this rule.
	{
		rule = {},
		properties = {
			focus = awful.client.focus.filter,
			raise = true,
			keys = client_keys,
			buttons = client_buttons,
			screen = awful.screen.preferred,
			placement = awful.placement.no_offscreen,
			floating = false,
			maximized = false,
			above = false,
			below = false,
			ontop = false,
			sticky = false,
			maximized_horizontal = false,
			maximized_vertical = false,
		},
	},

	-- keepassxc floating and centered
	-- { rule = { name = "keepassxc" }, properties = { floating = true } },

	{
		rule_any = {
			class = { "keepassxc" },
		},
		properties = {
			floating = true,
			placement = awful.placement.centered,
		},
		callback = function(c)
			naughty.notify({
				text = "KeepassXC rule applied: class=" .. tostring(c.class) .. ", type=" .. tostring(c.type),
			})
		end,
	},

	-- 1 [Browser]
	-- { rule = { class = "firefox" }, properties = { screen = 1, tag = 1, switchtotag = true } },
	-- { rule = { instance = "firefox" }, properties = { screen = "DP-4", tag = "1" } },
	{
		rule_any = {
			class = {
				"firefox",
				"browser",
				"brave",
				"chromium",
			},
		},
		properties = { screen = 1, tag = "1" },
		-- properties = {
		-- 	tag = screen[1].tags[1],
		-- 	switch_to_tags = true,
		-- },
	},
	-- 5 [superproductivity] -- Default start with this workspace.
	{
		rule_any = {
			class = {
				"superproductivity",
			},
		},
		properties = {
			screen = 1,
			tag = "5",
			-- switchtotag = true,
			-- urgency = "critical",
		},
	},

	-- {
	-- 	rule = { class = "superproductivity" },
	-- 	properties = { screen = 1, tag = "5", switchtotag = true, urgency = "critical" },
	-- },
}

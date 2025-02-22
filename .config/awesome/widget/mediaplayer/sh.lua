local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

local spotify_text = wibox.widget.textbox()

local function get_spotify_info()
	awful.spawn.easy_async_with_shell("playerctl status 2> /dev/null", function(status)
		local st = status:match("^%s*(.-)%s*$")
		if st == "Playing" or st == "Paused" then
			awful.spawn.easy_async_with_shell("playerctl metadata --format '{{artist}} - {{title}}'", function(meta)
				meta = meta:match("^%s*(.-)%s*$")
				if st == "Paused" then
					meta = " " .. meta
				end
				spotify_text:set_markup(meta)
			end)
		else
			spotify_text:set_markup("No media playing")
		end
	end)
end

-- Immediate update and periodic refresh every 150 seconds
get_spotify_info()
gears.timer({
	timeout = 150,
	autostart = true,
	callback = get_spotify_info,
})

-- Use asynchronous spawn with callback to update widget right after command execution
spotify_text:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn.easy_async_with_shell("playerctl play-pause", function()
			get_spotify_info()
		end)
	end),
	awful.button({}, 3, function()
		awful.spawn.easy_async_with_shell("playerctl next", function()
			get_spotify_info()
		end)
	end)
))

local spotify = wibox.widget({
	spotify_text,
	layout = wibox.layout.align.horizontal,
})

return spotify

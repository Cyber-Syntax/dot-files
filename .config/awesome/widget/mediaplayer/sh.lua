local wibox = require("wibox")
local gears = require("gears")
local awful = require("awful")

-- Storage Widget
local spotify_text = wibox.widget.textbox()
local cmd2 = [[sh /home/developer/.config/awesome/scripts/mediaplayer.sh]]

awesome.connect_signal("exit", function()
	awesome.kill(listener, awesome.unix_signal.SIGTERM)
end)

local spotify_up = function()
	listener = awful.spawn.with_line_callback(cmd2, {
		stdout = function(line)
			spotify_text:set_markup(string.format("%s ", line))
		end,
		stderr = function(line)
			naughty.notify({ text = "ERR:" .. line })
		end,
	})
end

-- Update every 5 minutes
gears.timer.start_new(300, spotify_up)

-- Add mouse button events to toggle play/pause and next track
spotify_text:buttons(gears.table.join(
	awful.button({}, 1, function()
		awful.spawn("playerctl play-pause")
	end),
	awful.button({}, 3, function()
		awful.spawn("playerctl next")
	end)
))

-- Listen for playerctl metadata changes
awful.spawn.with_line_callback("playerctl --follow", {
	stdout = function(line)
		spotify_up() -- Update the widget when playback status changes
	end,
})

local spotify = {
	layout = wibox.layout.align.horizontal,
	spotify_text,
}

return spotify

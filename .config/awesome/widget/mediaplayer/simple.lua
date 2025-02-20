llocal wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

-- Define the font with Pango markup for Font Awesome 5 Free Solid
local font = "<span font='Font Awesome 5 Free Solid 10'>"

-- Create a text widget to display the icon
local icon_widget = wibox.widget({
	markup = font .. "", -- Replace with the desired icon code
	widget = wibox.widget.textbox,
})

-- Function to update the icon based on media status
local function update_icon()
	awful.spawn.easy_async_with_shell("playerctl status", function(stdout, stderr, exitreason, exitcode)
		if exitcode == 0 then
			local icon = ""
			if stdout:match("Playing") then
				icon = "&#xf04c; " -- FontAwesome 'play' icon (U+F04B)
			elseif stdout:match("Paused") then
				icon = "&#xf04b; " -- FontAwesome 'pause' icon (U+F04C)
			end
			icon_widget.markup = font .. icon .. "</span>"
		else
			icon_widget.markup = font .. "" .. "</span>" -- Clear or set a default icon if playerctl fails
		end
	end)
end

-- Create a timer to update the widget periodically
local update_timer = gears.timer({
	timeout = 1,
	call_now = true,
	autostart = true,
	callback = update_icon,
})

return icon_widgetocal wibox = require("wibox")
local awful = require("awful")
local gears = require("gears")

-- Define the font with Pango markup for Font Awesome 5 Free Solid
local font = "<span font='Font Awesome 5 Free Solid 10'>"

-- Create a text widget to display the icon and media info
local icon_widget = wibox.widget({
    markup = font .. "", -- Replace with the desired icon code
    align = "left",
    valign = "center",
    widget = wibox.widget.textbox,
})

-- Function to update the widget based on media status
local function update_media_info()
    awful.spawn.easy_async_with_shell(
        "playerctl metadata artist title album xesam:contentCreated mpris:length position mpris:artUrl status",
        function(stdout, stderr, exitreason, exitcode)
            if exitcode == 0 then
                local lines = stdout:split("\n")
                local artist = lines[1] and lines[1]:match("xesam:artist='(.+)'") or "Unknown Artist"
                local title = lines[2] and lines[2]:match("xesam:title='(.+)'") or "Unknown Title"
                local album = lines[3] and lines[3]:match("album='(.+)'") or "Unknown Album"
                local date = lines[4] and lines[4]:match("xesam:contentCreated='(.+)'") or "Unknown Date"
                local length = lines[5] and lines[5]:match("mpris:length=(%d+)") or "0"
                local position = lines[6] and lines[6]:match("position=(%d+)") or "0"
                local art_url = lines[7] and lines[7]:match("mpris:artUrl='(.+)'") or ""
                local status = lines[8] and lines[8]:match("status=(.+)") or ""

                -- Convert length and position from microseconds to minutes:seconds
                local function format_time(microseconds)
                    local seconds = math.floor(microseconds / 1000000)
                    return string.format("%02d:%02d", math.floor(seconds / 60), seconds % 60)
                end

                local elapsed = format_time(position)
                local total = format_time(length)

                -- Determine the icon based on status
                local icon = ""
                if status == "Playing" then
                    icon = "&#xf144;" -- Play icon
                elseif status == "Paused" then
                    icon = "&#xf04c;" -- Pause icon
                else
                    icon = "&#x23f8;" -- Stop icon
                end

                -- Update the widget markup
                local markup = string.format(
                    "%s <span font='Sans 10pt'>%s - %s</span> <span font='Sans 8pt'>[%s / %s]</span>",
                    icon,
                    artist,
                    title,
                    elapsed,
                    total
                )

                icon_widget:set_markup(markup)
            else
                icon_widget:set_markup("No media playing")
            end
        end
    )
end

-- Create a timer to update the widget periodically
local update_timer = gears.timer({
    timeout = 1,
    call_now = true,
    autostart = true,
    callback = update_media_info,
})

return icon_widget

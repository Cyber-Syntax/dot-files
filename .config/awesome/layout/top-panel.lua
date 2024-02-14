local awful = require('awful')
local beautiful = require('beautiful')
local wibox = require('wibox')
local TaskList = require('widget.task-list')
local TagList = require('widget.tag-list')
local gears = require('gears')
local clickable_container = require('widget.material.clickable-container')
local mat_icon_button = require('widget.material.icon-button')
local mat_icon = require('widget.material.icon')
local dpi = require('beautiful').xresources.apply_dpi
local icons = require('theme.icons')

-- Titus - Horizontal Tray
local systray = wibox.widget.systray()
  systray:set_horizontal(true)
  systray:set_base_size(20)
  systray.forced_height = 20
-- ./Titus - Horizontal Tray

-- Clock setup
os.setlocale("tr_TR.UTF-8") -- Set the locale to Turkish

local textclock = wibox.widget.textclock("%c") -- %c represents the date and time
local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

-- Open gnome calendar after clicking the clock_widget
clock_widget:connect_signal("button::press", function(_, _, _, button)
  if button == 1 then
    awful.spawn("gnome-calendar")
  end
end)
-- ./clock_widget

-- pactl widget

local pactl_widget = require('widget.pactl-widget.volume')

-- ./pactl-widget

-- Volume widget for pipewire
local volume_widget = require('widget.volume-widget.volume')

-- ./Volume widget for pipewire


 -- Update status widget --
 local update_status_widget = wibox.widget.textbox()

 function update_status_widget_text()
 local command = '~/.config/awesome/dnf-update-status.py'
 awful.spawn.easy_async_with_shell(command, function(out)
     update_status_widget.text = out
 end)
 end

 -- Call the function once to set the initial text
 update_status_widget_text()

 -- Call the function periodically to update the text
 gears.timer.start_new(60, function() update_status_widget_text() return true end)

 -- Add a left click event to the widget
 update_status_widget:buttons(
 awful.util.table.join(
     awful.button({}, 1, function()
     local command = 'gnome-terminal -- bash -c "~/.config/awesome/update-dnf-flatpak.sh"'
     awful.spawn.easy_async_with_shell(command, function()
         -- Call the function again to update the text after the command has finished
         update_status_widget_text()
     end)
     end)
 )
 )
 -- ./update-dnf-flatpak.sh

 -- Sink Status widget
 -- sink-change.sh script to see running sink and change when left mouse button clicked
 -- @param: --status = active sink
 -- @param: --change = change sink to next available

 local sink_status_widget = wibox.widget.textbox()

 function sink_status_widget_text()
 local command = '~/.config/awesome/sink-change.sh --status'
 awful.spawn.easy_async_with_shell(command, function(out)
     local sink, volume_level = out:match("(.-)\n(.*)")
     local status = sink .. " " .. volume_level
     sink_status_widget.text = status
 end)
 end

 -- Call the function once to set the initial text
 sink_status_widget_text()

 -- Call the function periodically to update the text
 gears.timer.start_new(1, function() sink_status_widget_text() return true end)

 -- Add a left click event to the widget
 sink_status_widget:buttons(
 awful.util.table.join(
     awful.button({}, 1, function()
     awful.spawn('gnome-terminal -- bash -c "~/.config/awesome/sink-change.sh --change"')
     end)
 )
 )
 -- ./sink-change.sh

local add_button = mat_icon_button(mat_icon(icons.plus, dpi(24)))
add_button:buttons(
  gears.table.join(
    awful.button(
      {},
      1,
      nil,
      function()
        awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
      end
    )
  )
)

-- Create an imagebox widget which will contains an icon indicating which layout we're using.
-- We need one layoutbox per screen.
local LayoutBox = function(s)
  local layoutBox = clickable_container(awful.widget.layoutbox(s))
  layoutBox:buttons(
    awful.util.table.join(
      awful.button(
        {},
        1,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        3,
        function()
          awful.layout.inc(-1)
        end
      ),
      awful.button(
        {},
        4,
        function()
          awful.layout.inc(1)
        end
      ),
      awful.button(
        {},
        5,
        function()
          awful.layout.inc(-1)
        end
      )
    )
  )
  return layoutBox
end

local TopPanel = function(s)

    local panel =
    wibox(
    {
      ontop = true,
      screen = s,
      height = dpi(32),
      width = s.geometry.width,
      x = s.geometry.x,
      y = s.geometry.y,
      stretch = false,
      bg = beautiful.background.hue_800,
      fg = beautiful.fg_normal,
      struts = {
        top = dpi(32)
      }
    }
    )

    panel:struts(
      {
        top = dpi(32)
      }
    )

    panel:setup {
      layout = wibox.layout.align.horizontal,
      {
        -- Left widgets
        layout = wibox.layout.fixed.horizontal,

        -- Create a taglist widget
        TagList(s),

        -- Create a tasklist widget
        TaskList(s),

        -- add button for starting default application for that tag
        --add_button
      },
      nil,
      {
        -- Right widgets
        layout = wibox.layout.fixed.horizontal,

        -- Layout box
        LayoutBox(s),

        -- Sink Status
        sink_status_widget,
        wibox.container.margin(dpi(3), dpi(3), dpi(6), dpi(3)),

        -- DNF-FLATPAK Update Status
        update_status_widget,
        wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
        -- Clock
        clock_widget,

        -- PipeWire Volume
        --volume_widget,
        --pactl_widget,
      }
    }

  return panel
end

return TopPanel


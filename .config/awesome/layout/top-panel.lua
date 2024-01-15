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

-- Clock setup
os.setlocale("tr_TR.UTF-8") -- Set the locale to Turkish

local textclock = wibox.widget.textclock("%c") -- %c represents the date and time
local clock_widget = wibox.container.margin(textclock, dpi(13), dpi(13), dpi(9), dpi(8))

-- Add a calendar (credits to kylekewley for the original code)
local month_calendar = awful.widget.calendar_popup.month({
  screen = s,
  start_sunday = false,
  week_numbers = false
})
month_calendar:attach(textclock)

-- Update status widget --
local update_status_widget = wibox.widget.textbox()

function update_status_widget_text()
  local handle = io.popen('~/.config/awesome/dnf-update-status.py')
  local status = handle:read("*a")
  handle:close()
  update_status_widget.text = status
end

-- Call the function once to set the initial text
update_status_widget_text()

-- Call the function periodically to update the text
gears.timer.start_new(60, function() update_status_widget_text() return true end)

-- Add a left click event to the widget
update_status_widget:buttons(
  awful.util.table.join(
    awful.button({}, 1, function()
      awful.spawn('gnome-terminal -- bash -c "~/.config/awesome/update-dnf-flatpak.sh"')
      -- Call the function again to update the text after the command has finished
      update_status_widget_text()
    end)
  )
)
-- ./update-dnf-flatpak.sh

-- Volume widget for pipewire
--local volume_widget = require('widget.volume-widget.volume')

-- ./Volume widget for pipewire

-- sink-change.sh script to see running sink and change when left mouse button clicked
-- @param: --status = active sink
-- @param: --change = change sink to next available

-- Update status widget --
local sink_status_widget = wibox.widget.textbox()

function sink_status_widget_text()
  local handle = io.popen('~/.config/awesome/sink-change.sh --status')
  local status = handle:read("*a")
  handle:close()

  local sink, volume_level = status:match("(.-)\n(.*)")
  status = sink .. " " .. volume_level

  sink_status_widget.text = status
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
        layout = wibox.layout.fixed.horizontal,
        -- Create a taglist widget
        TagList(s),
        TaskList(s),
        add_button
      },
      nil,
      {
        layout = wibox.layout.fixed.horizontal,
        -- Layout box
        LayoutBox(s),
        -- Sink Status
        sink_status_widget,
        wibox.container.margin(dpi(3), dpi(3), dpi(6), dpi(3)),
        -- PipeWire Volume
        --volume_widget,
        wibox.container.margin(dpi(3), dpi(3), dpi(6), dpi(3)),
        -- DNF-FLATPAK Update Status
        update_status_widget,
        wibox.container.margin(systray, dpi(3), dpi(3), dpi(6), dpi(3)),
        -- Clock
        clock_widget,

      }
    }

  return panel
end

return TopPanel

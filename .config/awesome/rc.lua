-- awesome_mode: api-level=4:screen=on
-- If LuaRocks is installed, make sure that packages installed through it are
-- found (e.g. lgi). If LuaRocks is not installed, do nothing.
pcall(require, "luarocks.loader")

-- Standard awesome library
local gears = require("gears")
local awful = require("awful")
require("awful.autofocus")
-- Widget and layout library
local wibox = require("wibox")
-- Theme handling library
local beautiful = require("beautiful")
-- Notification library
local naughty = require("naughty")
-- Declarative object management
local ruled = require("ruled")
local menubar = require("menubar")
local hotkeys_popup = require("awful.hotkeys_popup")

-- Enable hotkeys help widget for VIM and other apps
-- when client with a matching name is opened:
require("awful.hotkeys_popup.keys")

-- -- Autostart apps
awful.spawn.with_shell("~/.config/awesome/autorun.sh")

-- Theme
beautiful.init(require('theme'))

-- Layout
require('layout')

-- Init all modules
require('module.notifications')
require('module.auto-start')
require('module.decorate-client')

-- Setup all configurations
require('configuration.client')
require('configuration.tags')
_G.root.keys(require('configuration.keys.global'))


-- {{{ Error handling
-- Check if awesome encountered an error during startup and fell back to
-- another config (This code will only ever execute for the fallback config)
naughty.connect_signal("request::display_error", function(message, startup)
    naughty.notification {
        urgency = "critical",
        title   = "Oops, an error happened"..(startup and " during startup!" or "!"),
        message = message
    }
end)
-- }}}

-- {{{ Variable definitions
-- Themes define colours, icons, font and wallpapers.
beautiful.init(gears.filesystem.get_themes_dir() .. "default/theme.lua")

-- -- This is used later as the default terminal and editor to run.
-- terminal = "gnome-terminal"
-- editor = os.getenv("EDITOR") or "nano"
-- editor_cmd = terminal .. " -e " .. editor

-- -- Default modkey.
-- -- Usually, Mod4 is the key with a logo between Control and Alt.
-- -- If you do not like this or do not have such a key,
-- -- I suggest you to remap Mod4 to another key using xmodmap or other tools.
-- -- However, you can use another modifier like Mod1, but it may interact with others.
-- modkey = "Mod4"
-- -- }}}

-- -- {{{ Menu
-- -- Create a launcher widget and a main menu
-- myawesomemenu = {
--    { "hotkeys", function() hotkeys_popup.show_help(nil, awful.screen.focused()) end },
--    { "manual", terminal .. " -e man awesome" },
--    { "edit config", editor_cmd .. " " .. awesome.conffile },
--    { "restart", awesome.restart },
--    { "quit", function() awesome.quit() end },
-- }

-- mymainmenu = awful.menu({ items = { { "awesome", myawesomemenu, beautiful.awesome_icon },
--                                     { "open terminal", terminal }
--                                   }
--                         })

-- mylauncher = awful.widget.launcher({ image = beautiful.awesome_icon,
--                                      menu = mymainmenu })

-- -- Menubar configuration
-- menubar.utils.terminal = terminal -- Set the terminal for applications that require it
-- -- }}}

-- {{{ Tag layout
-- Table of layouts to cover with awful.layout.inc, order matters.
tag.connect_signal("request::default_layouts", function()
    awful.layout.append_default_layouts({
        awful.layout.suit.max,
        --awful.layout.suit.floating,
        --awful.layout.suit.tile,
        -- awful.layout.suit.tile.left,
        -- awful.layout.suit.tile.bottom,
        -- awful.layout.suit.tile.top,
        -- awful.layout.suit.fair,
        -- awful.layout.suit.fair.horizontal,
        -- awful.layout.suit.spiral,
        -- awful.layout.suit.spiral.dwindle,
        -- awful.layout.suit.max.fullscreen,
        -- awful.layout.suit.magnifier,
        -- awful.layout.suit.corner.nw,
    })
end)
-- }}}

-- -- {{{ Wallpaper
-- screen.connect_signal("request::wallpaper", function(s)
--     awful.wallpaper {
--         screen = s,
--         widget = {
--             {
--                 image     = beautiful.wallpaper,
--                 upscale   = true,
--                 downscale = true,
--                 widget    = wibox.widget.imagebox,
--             },
--             valign = "center",
--             halign = "center",
--             tiled  = false,
--             widget = wibox.container.tile,
--         }
--     }
-- end)
-- -- }}}

-- -- {{{ Wibar

-- -- Keyboard map indicator and switcher
-- mykeyboardlayout = awful.widget.keyboardlayout()

-- -- Create a textclock widget
-- mytextclock = wibox.widget.textclock()

-- screen.connect_signal("request::desktop_decoration", function(s)
--     -- Each screen has its own tag table.
--     --awful.tag({ "1", "2", "3"}, s, awful.layout.layouts[1])

--     -- Create a promptbox for each screen
--     s.mypromptbox = awful.widget.prompt()

--     -- Create an imagebox widget which will contain an icon indicating which layout we're using.
--     -- We need one layoutbox per screen.
--     s.mylayoutbox = awful.widget.layoutbox {
--         screen  = s,
--         buttons = {
--             awful.button({ }, 1, function () awful.layout.inc( 1) end),
--             awful.button({ }, 3, function () awful.layout.inc(-1) end),
--             awful.button({ }, 4, function () awful.layout.inc( 1) end),
--             awful.button({ }, 5, function () awful.layout.inc(-1) end),
--         }
--     }

--     -- Create a taglist widget
--     s.mytaglist = awful.widget.taglist {
--         screen  = s,
--         filter  = awful.widget.taglist.filter.all,
--         buttons = {
--             awful.button({ }, 1, function(t) t:view_only() end),
--             awful.button({ modkey }, 1, function(t)
--                                             if client.focus then
--                                                 client.focus:move_to_tag(t)
--                                             end
--                                         end),
--             awful.button({ }, 3, awful.tag.viewtoggle),
--             awful.button({ modkey }, 3, function(t)
--                                             if client.focus then
--                                                 client.focus:toggle_tag(t)
--                                             end
--                                         end),
--             awful.button({ }, 4, function(t) awful.tag.viewprev(t.screen) end),
--             awful.button({ }, 5, function(t) awful.tag.viewnext(t.screen) end),
--         }
--     }

--     -- Create a tasklist widget
--     s.mytasklist = awful.widget.tasklist {
--         screen  = s,
--         filter  = awful.widget.tasklist.filter.currenttags,
--         buttons = {
--             awful.button({ }, 1, function (c)
--                 c:activate { context = "tasklist", action = "toggle_minimization" }
--             end),
--             awful.button({ }, 3, function() awful.menu.client_list { theme = { width = 250 } } end),
--             awful.button({ }, 4, function() awful.client.focus.byidx(-1) end),
--             awful.button({ }, 5, function() awful.client.focus.byidx( 1) end),
--         }
--     }

--     -- Update status widget --
--     local update_status_widget = wibox.widget.textbox()

--     function update_status_widget_text()
--     local command = '~/.config/awesome/dnf-update-status.py'
--     awful.spawn.easy_async_with_shell(command, function(out)
--         update_status_widget.text = out
--     end)
--     end

--     -- Call the function once to set the initial text
--     update_status_widget_text()

--     -- Call the function periodically to update the text
--     gears.timer.start_new(60, function() update_status_widget_text() return true end)

--     -- Add a left click event to the widget
--     update_status_widget:buttons(
--     awful.util.table.join(
--         awful.button({}, 1, function()
--         local command = 'gnome-terminal -- bash -c "~/.config/awesome/update-dnf-flatpak.sh"'
--         awful.spawn.easy_async_with_shell(command, function()
--             -- Call the function again to update the text after the command has finished
--             update_status_widget_text()
--         end)
--         end)
--     )
--     )
--     -- ./update-dnf-flatpak.sh

--     -- Sink Status widget
--     -- sink-change.sh script to see running sink and change when left mouse button clicked
--     -- @param: --status = active sink
--     -- @param: --change = change sink to next available

--     local sink_status_widget = wibox.widget.textbox()

--     function sink_status_widget_text()
--     local command = '~/.config/awesome/sink-change.sh --status'
--     awful.spawn.easy_async_with_shell(command, function(out)
--         local sink, volume_level = out:match("(.-)\n(.*)")
--         local status = sink .. " " .. volume_level
--         sink_status_widget.text = status
--     end)
--     end

--     -- Call the function once to set the initial text
--     sink_status_widget_text()

--     -- Call the function periodically to update the text
--     gears.timer.start_new(1, function() sink_status_widget_text() return true end)

--     -- Add a left click event to the widget
--     sink_status_widget:buttons(
--     awful.util.table.join(
--         awful.button({}, 1, function()
--         awful.spawn('gnome-terminal -- bash -c "~/.config/awesome/sink-change.sh --change"')
--         end)
--     )
--     )
--     -- ./sink-change.sh

--     -- Create the wibox
--     s.mywibox = awful.wibar {
--         position = "top",
--         screen   = s,
--         widget   = {
--             layout = wibox.layout.align.horizontal,
--             { -- Left widgets
--                 layout = wibox.layout.fixed.horizontal,
--                 --mylauncher,
--                 s.mytaglist,
--                 s.mypromptbox,
--             },
--             s.mytasklist, -- Middle widget
--             { -- Right widgets
--                 layout = wibox.layout.fixed.horizontal,
--                 --mykeyboardlayout,
--                 s.mylayoutbox,
--                 -- pactl sink status
--                 sink_status_widget,

--                 -- update_status_widget,
--                 update_status_widget,

--                 wibox.widget.systray(),
--                 mytextclock,
--             },
--         }
--     }
-- end)
-- -- }}}

-- {{{ Mouse bindings
awful.mouse.append_global_mousebindings({
    awful.button({ }, 3, function () mymainmenu:toggle() end),
    awful.button({ }, 4, awful.tag.viewprev),
    awful.button({ }, 5, awful.tag.viewnext),
})
-- }}}

-- {{{ Rules
-- Rules to apply to new clients.
ruled.client.connect_signal("request::rules", function()
    -- All clients will match this rule.
    ruled.client.append_rule {
        id         = "global",
        rule       = { },
        properties = {
            focus     = awful.client.focus.filter,
            raise     = true,
            screen    = awful.screen.preferred,
            placement = awful.placement.no_overlap+awful.placement.no_offscreen
        }
    }

    -- Floating clients.
    ruled.client.append_rule {
        id       = "floating",
        rule_any = {
            instance = { "copyq", "pinentry" },
            class    = {
                "Arandr", "Blueman-manager", "Gpick", "Kruler", "Sxiv",
                "Tor Browser", "Wpa_gui", "veromix", "xtightvncviewer"
            },
            -- Note that the name property shown in xprop might be set slightly after creation of the client
            -- and the name shown there might not match defined rules here.
            name    = {
                "Event Tester",  -- xev.
            },
            role    = {
                "AlarmWindow",    -- Thunderbird's calendar.
                "ConfigManager",  -- Thunderbird's about:config.
                "pop-up",         -- e.g. Google Chrome's (detached) Developer Tools.
            }
        },
        properties = { floating = true }
    }

    -- Add titlebars to normal clients and dialogs
    ruled.client.append_rule {
        id         = "titlebars",
        rule_any   = { type = { "normal", "dialog" } },
        properties = { titlebars_enabled = true      }
    }

    -- Set superproductivity to always on the tag name "1" on screen 3.
    ruled.client.append_rule {
        rule       = { class = "superproductivity" },
        properties = { screen = 3, tag = "1" }
    }

    -- Set Firefox to always map on the tag named "2" on screen 1.
    -- ruled.client.append_rule {
    --     rule       = { class = "Firefox"     },
    --     properties = { screen = 1, tag = "2" }
    -- }
end)
-- }}}

-- Garbage collection
-- Run garbage collector regularly to prevent memory leaks
gears.timer {
    timeout = 30,
    autostart = true,
    callback = function() collectgarbage() end
}

-- {{{ Notifications

ruled.notification.connect_signal('request::rules', function()
    -- All notifications will match this rule.
    ruled.notification.append_rule {
        rule       = { },
        properties = {
            screen           = awful.screen.preferred,
            implicit_timeout = 5,
        }
    }
end)

naughty.connect_signal("request::display", function(n)
    naughty.layout.box { notification = n }
end)
-- }}}

-- Enable sloppy focus, so that focus follows mouse.
client.connect_signal("mouse::enter", function(c)
    c:activate { context = "mouse_enter", raise = false }
end)
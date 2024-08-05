local awful = require('awful')
local gears = require('gears')
local client_keys = require('configuration.client.keys')
local client_buttons = require('configuration.client.buttons')

-- Rules
awful.rules.rules = {

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
      maximized_vertical = false
    }
  },

  -- keepassxc floating and centered
  {
    rule = { class = "keepassxc" },
    properties = {
      floating = true,
      placement = awful.placement.centered
    }
  },

        -- Not working, need to find a way to make it work
  -- -- rule for superproductivity to open on screen 3
  --   { rule = { class = "superproductivity" },
  --     properties = { screen = 3 }
  --   },

  -- --Titlebars
  -- {
  --   rule_any = {type = {'dialog'}, class = {'Wicd-client.py', 'calendar.google.com'}},
  --   properties = {
  --     placement = awful.placement.centered,
  --     ontop = true,
  --     floating = true,
  --     drawBackdrop = true,
  --     shape = function()
  --       return function(cr, w, h)
  --         gears.shape.rounded_rect(cr, w, h, 8)
  --       end
  --     end,
  --     skip_decoration = true
  --   }
  -- }

    -- not working, need to find a way to make it work
  -- {
  --   rule_any = {type = {'dialog'}, class = {'xdg-desktop-portal-gtk'}, name = {'Open Folder'} },
  --   properties = {
  --     ontop = false,
  --     placement = awful.placement.centered,
  --     floating = true,
  --     skip_decoration = true
  --   }
  -- },

}

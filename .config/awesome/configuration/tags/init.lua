local awful = require('awful')
local gears = require('gears')
local icons = require('theme.icons')
local apps = require('configuration.apps')

local tags = {
  {
    icon = icons.chrome,
    type = 'chrome',
    defaultApp = apps.default.browser,
    loyout =   awful.layout.suit.max,
    screen = 1
  },
  {
    icon = icons.code,
    type = 'code',
    defaultApp = apps.default.editor,
    loyout =   awful.layout.suit.max,
    screen = 1
  },
  {
    icon = icons.lab,
    type = 'any',
    defaultApp = apps.default.rofi,
    loyout =   awful.layout.suit.max,
    screen = 1
  },
  -- {
  --   icon = icons.folder,
  --   type = 'files',
  --   defaultApp = apps.default.files,
  --   loyout =   awful.layout.suit.tile,
  --   screen = 1
  -- },
  -- {
  --   icon = icons.social,
  --   type = 'social',
  --   defaultApp = apps.default.rofi,
  --   loyout =   awful.layout.suit.tile,
  --   screen = 1
  -- },
  -- {
  --   icon = icons.music,
  --   type = 'music',
  --   defaultApp = apps.default.music,
  --   loyout =   awful.layout.suit.tile,
  --   screen = 1
  -- },
  -- {
  --   icon = icons.game,
  --   type = 'game',
  --   defaultApp = apps.default.rofi,
  --   loyout =   awful.layout.suit.floating,
  --   screen = 1
  -- },
}

-- awful.layout.layouts = {
--   awful.layout.suit.tile,
--   awful.layout.suit.max,
--   awful.layout.suit.floating
-- }

-- Define layouts for new version
local layouts = {
  awful.layout.suit.tile,
  awful.layout.suit.floating,
  awful.layout.suit.max,
}

-- Set the default layout
awful.layout.append_default_layouts(layouts)

awful.screen.connect_for_each_screen(
  function(s)
    for i, tag in pairs(tags) do
      awful.tag.add(
        i,
        {
          icon = tag.icon,
          icon_only = true,
          layout = tag.loyout, -- default: awful.layout.suit.tile
          gap_single_client = false,
          gap = 4,
          screen = s,
          defaultApp = tag.defaultApp,
          selected = i == 1
        }
      )
    end
  end
)

_G.tag.connect_signal(
  'property::layout',
  function(t)
    local currentLayout = awful.tag.getproperty(t, 'layout')
    if (currentLayout == awful.layout.suit.max) then
      t.gap = 0
    else
      t.gap = 4
    end
  end
)

local awful = require('awful')
require('awful.autofocus')
local beautiful = require('beautiful')
local hotkeys_popup = require('awful.hotkeys_popup').widget

local modkey = require('configuration.keys.mod').modKey
local altkey = require('configuration.keys.mod').altKey
local apps = require('configuration.apps')
-- Key bindings
local globalKeys =
  awful.util.table.join(
  -- Hotkeys
  awful.key({modkey}, 'F1', hotkeys_popup.show_help, {description = 'Show help', group = 'awesome'}),
  -- Tag browsing
  --awful.key({modkey}, 'w', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  --awful.key({modkey}, 's', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  --awful.key({altkey, 'Control'}, 'Up', awful.tag.viewprev, {description = 'view previous', group = 'tag'}),
  --awful.key({altkey, 'Control'}, 'Down', awful.tag.viewnext, {description = 'view next', group = 'tag'}),
  awful.key({modkey}, 'Escape', awful.tag.history.restore, {description = 'go back', group = 'tag'}),
  -- rofi
  awful.key(
    {modkey},
    'x',
    function()
      awful.spawn.with_shell('~/.config/rofi/powermenu/type-6/powermenu.sh')
    end,
    {description = 'powermenu', group = 'rofi'}
  ),
  awful.key(
    {modkey},
    'r',
    function()
      awful.spawn.with_shell('~/.config/rofi/launchers/type-6/launcher.sh')
    end,
    {description = 'launcher', group = 'rofi'}
  ),
  -- Sink Selection
  awful.key(
    {modkey},
    'm',
    function()
      awful.spawn.with_shell('pactl set-default-sink $(pactl list short sinks |awk \'{print $2}\' |rofi -dmenu)')
    end,
    {description = 'applet', group = 'rofi'}
  ),
  -- siyuan
  awful.key(
    {modkey},
    's',
    function()
      awful.spawn.with_shell('~/Documents/appimages/siyuan.AppImage')
    end,
    {description = 'siyuan', group = 'awesome'}
  ),
  -- Focus for screen
  awful.key(
    {modkey},
    'a',
    function()
      awful.screen.focus_relative(1)
    end,
    {description = 'focus the next screen', group = 'screen'}
  ),
  awful.key(
    {modkey},
    'd',
    function()
      awful.screen.focus_relative(-1)
    end,
    {description = 'focus the previous screen', group = 'screen'}
  ),
  -- Pipewire/Pulseaudio keys
  awful.key(
    {},
    'XF86AudioRaiseVolume',
    function()
      awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ +5%')
    end,
    {description = 'volume up', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioLowerVolume',
    function()
      awful.spawn('pactl set-sink-volume @DEFAULT_SINK@ -5%')
    end,
    {description = 'volume down', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioMute',
    function()
      awful.spawn('pactl set-sink-mute @DEFAULT_SINK@ toggle')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  -- mic
  -- raise
  awful.key(
    {altkey},
    'XF86AudioRaiseVolume',
    function()
      awful.spawn('pactl set-source-volume @DEFAULT_SOURCE@ +5%')
    end,
    {description = 'volume up', group = 'hotkeys'}
  ),
  -- lower
  awful.key(
    {altkey},
    'XF86AudioLowerVolume',
    function()
      awful.spawn('pactl set-source-volume @DEFAULT_SOURCE@ -5%')
    end,
    {description = 'volume down', group = 'hotkeys'}
  ),
  -- mute
  awful.key(
    {altkey},
    'XF86AudioMute',
    function()
      awful.spawn('pactl set-source-mute @DEFAULT_SOURCE@ toggle')
    end,
    {description = 'toggle mute', group = 'hotkeys'}
  ),
  -- Media keys
  awful.key(
    {},
    'XF86AudioPlay',
    function()
      awful.spawn('playerctl play-pause')
    end,
    {description = 'play/pause', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioNext',
    function()
      awful.spawn('playerctl next')
    end,
    {description = 'next', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioPrev',
    function()
      awful.spawn('playerctl previous')
    end,
    {description = 'previous', group = 'hotkeys'}
  ),
  awful.key(
    {},
    'XF86AudioStop',
    function()
      awful.spawn('playerctl stop')
    end,
    {description = 'stop', group = 'hotkeys'}
  ),

  awful.key(
    {altkey},
    'space',
    function()
      awful.spawn('rofi -combi-modi window,drun -show combi -modi combi')
    end,
    {description = 'Show main menu', group = 'awesome'}
  ),
  -- awful.key(
  --   {modkey, 'Shift'},
  --   'r',
  --   function()
  --     awful.spawn('reboot')
  --   end,
  --   {description = 'Reboot Computer', group = 'awesome'}
  -- ),
  -- awful.key(
  --   {modkey, 'Shift'},
  --   's',
  --   function()
  --     awful.spawn('shutdown now')
  --   end,
  --   {description = 'Shutdown Computer', group = 'awesome'}
  -- ),
  -- awful.key(
  --   {modkey, 'Shift'},
  --   'l',
  --   function()
  --     _G.exit_screen_show()
  --   end,
  --   {description = 'Log Out Screen', group = 'awesome'}
  -- ),
  awful.key({modkey}, 'u', awful.client.urgent.jumpto, {description = 'jump to urgent client', group = 'client'}),
  awful.key(
    {altkey},
    'Tab',
    function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(1)
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    {description = 'Switch to next window', group = 'client'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'Tab',
    function()
      --awful.client.focus.history.previous()
      awful.client.focus.byidx(-1)
      if _G.client.focus then
        _G.client.focus:raise()
      end
    end,
    {description = 'Switch to previous window', group = 'client'}
  ),
  -- Programms

  awful.key(
    {modkey},
    'v',
    function()
      awful.util.spawn(apps.default.editor)
    end,
    {description = 'Open a text/code editor', group = 'launcher'}
  ),
  awful.key(
    {modkey},
    '<',
    function()
      awful.util.spawn(apps.default.browser)
    end,
    {description = 'Open a browser', group = 'launcher'}
  ),
  -- Standard program
  awful.key(
    {modkey},
    'Return',
    function()
      awful.spawn(apps.default.terminal)
    end,
    {description = 'Open a terminal', group = 'launcher'}
  ),
  awful.key({modkey, 'Control'}, 'r', _G.awesome.restart, {description = 'reload awesome', group = 'awesome'}),
  awful.key({modkey, 'Control'}, 'q', _G.awesome.quit, {description = 'quit awesome', group = 'awesome'}),
  awful.key(
    {altkey, 'Shift'},
    'Right',
    function()
      awful.tag.incmwfact(0.05)
    end,
    {description = 'Increase master width factor', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'Left',
    function()
      awful.tag.incmwfact(-0.05)
    end,
    {description = 'Decrease master width factor', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'Down',
    function()
      awful.client.incwfact(0.05)
    end,
    {description = 'Decrease master height factor', group = 'layout'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'Up',
    function()
      awful.client.incwfact(-0.05)
    end,
    {description = 'Increase master height factor', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'Left',
    function()
      awful.tag.incnmaster(1, nil, true)
    end,
    {description = 'Increase the number of master clients', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'Right',
    function()
      awful.tag.incnmaster(-1, nil, true)
    end,
    {description = 'Decrease the number of master clients', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'Left',
    function()
      awful.tag.incncol(1, nil, true)
    end,
    {description = 'Increase the number of columns', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'Right',
    function()
      awful.tag.incncol(-1, nil, true)
    end,
    {description = 'Decrease the number of columns', group = 'layout'}
  ),
  awful.key(
    {modkey},
    'Tab',
    function()
      awful.layout.inc(1)
    end,
    {description = 'Select next', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Shift'},
    'space',
    function()
      awful.layout.inc(-1)
    end,
    {description = 'Select previous', group = 'layout'}
  ),
  awful.key(
    {modkey, 'Control'},
    'n',
    function()
      local c = awful.client.restore()
      -- Focus restored client
      if c then
        _G.client.focus = c
        c:raise()
      end
    end,
    {description = 'restore minimized', group = 'client'}
  ),
  -- Others
  awful.key(
    {modkey},
    'l',
    function()
      awful.spawn(apps.default.lock)
    end,
    {description = 'Lock the screen', group = 'awesome'}
  ),
  awful.key(
    {modkey},
    'Print',
    function()
      awful.util.spawn_with_shell(apps.default.delayed_screenshot)
    end,
    {description = 'Mark an area and screenshot it 10 seconds later (clipboard)', group = 'screenshots (clipboard)'}
  ),
  awful.key(
    {modkey},
    'p',
    function()
      awful.util.spawn_with_shell(apps.default.screenshot)
    end,
    {description = 'Take a screenshot of your active monitor and copy it to clipboard', group = 'screenshots (clipboard)'}
  ),
  awful.key(
    {altkey, 'Shift'},
    'p',
    function()
      awful.util.spawn_with_shell(apps.default.region_screenshot)
    end,
    {description = 'Mark an area and screenshot it to your clipboard', group = 'screenshots (clipboard)'}
  ),

  -- Screen management
  awful.key(
    {modkey},
    'w',
    awful.client.movetoscreen,
    {description = 'move window to next screen', group = 'client'}
  ),
  awful.key(
    {modkey},
    'e',
    function()
        local ns = client.focus.screen.index - 1
        awful.client.movetoscreen(c, ns)
    end,
    {description = "move to screen on the left", group = "client"}
  ),
  awful.key(
    {modkey},
    'j',
  function ()
      awful.client.focus.bydirection("left")
  end
  ),


  ---- Same with `awful.client.movetoscreen` but saved here for reference
  -- awful.key(
  --   {modkey},
  --   'w',
  --   function()
  --       local ns = client.focus.screen.index + 1
  --       awful.client.movetoscreen(c, ns)
  --   end,
  --   {description = "move to screen on the right", group = "client"}
  -- ),

  -- Open default program for tag
  awful.key(
    {modkey},
    't',
    function()
      awful.spawn(
          awful.screen.focused().selected_tag.defaultApp,
          {
            tag = _G.mouse.screen.selected_tag,
            placement = awful.placement.bottom_right
          }
        )
    end,
    {description = 'Open default program for tag/workspace', group = 'tag'}
  ),

  -- File Manager
  awful.key(
    {modkey},
    'z',
    function()
      awful.util.spawn(apps.default.files)
    end,
    {description = 'filebrowser', group = 'hotkeys'}
  ),
  -- Emoji Picker
  awful.key(
    {modkey},
    'o',
    function()
      awful.util.spawn_with_shell('ibus emoji')
    end,
    {description = 'Open the ibus emoji picker to copy an emoji to your clipboard', group = 'hotkeys'}
  )
)

-- Bind all key numbers to tags.
-- Be careful: we use keycodes to make it works on any keyboard layout.
-- This should map on the top row of your keyboard, usually 1 to 9.
for i = 1, 9 do
  -- Hack to only show tags 1 and 9 in the shortcut window (mod+s)
  local descr_view, descr_toggle, descr_move, descr_toggle_focus
  if i == 1 or i == 9 then
    descr_view = {description = 'view tag #', group = 'tag'}
    descr_toggle = {description = 'toggle tag #', group = 'tag'}
    descr_move = {description = 'move focused client to tag #', group = 'tag'}
    descr_toggle_focus = {description = 'toggle focused client on tag #', group = 'tag'}
  end
  globalKeys =
    awful.util.table.join(
    globalKeys,
    -- View tag only.
    awful.key(
      {modkey},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          tag:view_only()
        end
      end,
      descr_view
    ),
    -- Toggle tag display.
    awful.key(
      {modkey, 'Control'},
      '#' .. i + 9,
      function()
        local screen = awful.screen.focused()
        local tag = screen.tags[i]
        if tag then
          awful.tag.viewtoggle(tag)
        end
      end,
      descr_toggle
    ),
    -- Move client to tag.
    awful.key(
      {modkey, 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:move_to_tag(tag)
          end
        end
      end,
      descr_move
    ),
    -- Toggle tag on focused client.
    awful.key(
      {modkey, 'Control', 'Shift'},
      '#' .. i + 9,
      function()
        if _G.client.focus then
          local tag = _G.client.focus.screen.tags[i]
          if tag then
            _G.client.focus:toggle_tag(tag)
          end
        end
      end,
      descr_toggle_focus
    )
    ---- Default client focus
    -- awful.key(
    --   {modkey},
    --   'd',
    --   function()
    --     awful.client.focus.byidx(1)
    --   end,
    --   {description = 'Focus next by index', group = 'client'}
    -- ),
    -- awful.key(
    --   {modkey},
    --   'a',
    --   function()
    --     awful.client.focus.byidx(-1)
    --   end,
    --   {description = 'Focus previous by index', group = 'client'}
    -- ),
    -- awful.key(
    --   {modkey},
    --   'r',
    --   function()
    --     awful.spawn('rofi -combi-modi window,drun -show combi -modi combi')
    --   end,
    --   {description = 'Main menu', group = 'awesome'}
    -- ),

    -- Dropdown application
    -- awful.key(
    --   {modkey},
    --   'z',
    --   function()
    --     _G.toggle_quake()
    --   end,
    --   {description = 'dropdown application', group = 'launcher'}
    -- ),

    -- -- Brightness
    -- awful.key(
    --   {},
    --   'XF86MonBrightnessUp',
    --   function()
    --     awful.spawn('xbacklight -inc 10')
    --   end,
    --   {description = '+10%', group = 'hotkeys'}
    -- ),
    -- awful.key(
    --   {},
    --   'XF86MonBrightnessDown',
    --   function()
    --     awful.spawn('xbacklight -dec 10')
    --   end,
    --   {description = '-10%', group = 'hotkeys'}
    -- ),
  )
end

return globalKeys

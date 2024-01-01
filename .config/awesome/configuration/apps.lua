local filesystem = require('gears.filesystem')
local awful = require('awful')
-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require('beautiful').xresources.apply_dpi
local get_dpi = require('beautiful').xresources.get_dpi
local rofi_command = 'env /usr/bin/rofi -dpi ' .. get_dpi() .. ' -width ' .. with_dpi(400) .. ' -show drun -theme ' .. filesystem.get_configuration_dir() .. '/configuration/rofi.rasi -run-command "/bin/bash -c -i \'shopt -s expand_aliases; {cmd}\'"'

return {
  -- List of apps to start by default on some actions
  default = {
    terminal = 'alacritty',
    files = 'nautilus',
    music = 'flatpak run org.js.nuclear.Nuclear',
    lock = 'i3lock',
    browser = 'firefox',
    editor = 'flatpak run com.visualstudio.code', -- gui text editor
    screenshot = 'flameshot screen -p ~/Pictures',
    region_screenshot = 'flameshot gui -p ~/Pictures',
    delayed_screenshot = 'flameshot screen -p ~/Pictures -d 5000',
    rofi = rofi_command,
    social = 'discord',
    game = rofi_command,
    quake = 'alacritty',
  },
  -- List of apps to start once on start-up
  run_on_start_up = {
    --'sleep 3 && ~/Documents/screenloyout/xrandr.sh', -- It's setting in xorg.conf now
    '~/Documents/repository/WallpaperChanger/main.py',
    '$HOME/Documents/appimages/super-productivity.AppImage',
    'numlockx on', -- enable numlock
    'keepassxc',
    'lxpolkit',
    'nm-applet', 
    'eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)', -- credential manager
    'flameshot',
    --'/usr/libexec/gsd-xsettings',
    --'picom --config ' .. filesystem.get_configuration_dir() .. '/configuration/picom.conf',
    --'pnmixer', -- shows an audiocontrol applet in systray when installed.
    --'blueberry-tray', -- Bluetooth tray icon
    --'/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & 
    -- 'synology-drive -minimized',
    --
    -- Add applications that need to be killed between reloads
    -- to avoid multipled instances, inside the awspawn script
    --'~/.config/awesome/configuration/awspawn' -- Spawn "dirty" apps that can linger between sessions
  }
}

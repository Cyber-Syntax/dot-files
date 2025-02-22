local filesystem = require("gears.filesystem")
local awful = require("awful")

-- Thanks to jo148 on github for making rofi dpi aware!
local with_dpi = require("beautiful").xresources.apply_dpi
local get_dpi = require("beautiful").xresources.get_dpi
local rofi_command = "env /usr/bin/rofi -dpi "
	.. get_dpi()
	.. " -width "
	.. with_dpi(400)
	.. " -show drun -theme "
	.. filesystem.get_configuration_dir()
	--FIX: style works but not able to open any app..
	.. "/configuration/style-10.rasi -run-command \"/bin/bash -c -i 'shopt -s expand_aliases; {cmd}'\""

-- Run once apps

local naughty = require("naughty")

awful.spawn.easy_async_with_shell(
	"~/.config/awesome/scripts/autostart.sh",
	function(stdout, stderr, exitreason, exitcode)
		if exitcode ~= 0 then
			naughty.notify({
				preset = naughty.config.presets.critical,
				title = "Autostart Script Error",
				text = stderr or "Unknown error",
			})
		else
			-- Optionally process stdout if needed
			print("Autostart completed successfully:", stdout)
		end
	end
)
--
--NOTE: async more better then spawn with shell?
-- awful.spawn.with_shell("~/.config/awesome/scripts/autostart.sh")

---- Function to run a command only once
-- local function run_once(cmd)
-- 	-- If the command has arguments, extract the first token as the process name.
-- 	local findme = cmd
-- 	local firstspace = cmd:find(" ")
-- 	if firstspace then
-- 		findme = cmd:sub(1, firstspace - 1)
-- 	end
-- 	awful.spawn.with_shell(string.format("pgrep -u $USER -x %s || (%s)", findme, cmd))
-- end
--
-- -- List your startup commands here:
-- run_once("sh /home/developer/Documents/scripts/screenloyout/asus_only.sh")
-- run_once("python3 /home/developer/Documents/repository/WallpaperChanger/main.py")
-- -- run_once("setxkbmap tr") -- set keyboard layout
-- -- run_once("numlockx on") -- enable numlock
-- -- run_once("nm-applet") -- network manager applet
-- -- run_once("gammastep") -- redshift alternative (works on both Wayland and Xorg)
-- -- run_once("syncthingtray") -- syncthing tray icon
-- run_once("TZ=Europe/Istanbul /home/developer/Documents/appimages/super-productivity.AppImage")
-- -- run_once("keepassxc")

-- function run_once(cmd)
-- 	findme = cmd
-- 	firstspace = cmd:find(" ")
-- 	if firstspace then
-- 		findme = cmd:sub(0, firstspace - 1)
-- 	end
-- 	awful.spawn.with_shell("pgrep -u $USER -x " .. findme .. " > /dev/null || (" .. cmd .. ")")
-- end
-- run_once("keepassxc")
-- run_once("nm-applet")
-- run_once("$HOME/Documents/repository/WallpaperChanger/main.py")
-- run_once("$HOME/Documents/scripts/screenloyout")
-- run_once("numlockx on")
--
return {
	-- List of apps to start by default on some actions
	default = {
		terminal = "kitty",
		files = "pcmanfm",
		music = "spotify",
		lock = "i3lock",
		browser = "firefox",
		rofi = rofi_command,
		quake = "terminator",
		screenshot = "flameshot screen -p ~/Pictures",
		region_screenshot = "flameshot gui -p ~/Pictures",
		delayed_screenshot = "flameshot screen -p ~/Pictures -d 5000",
		freetube = "freetube",
		note = "obsidian",
		game = rofi_command,
		-- music = rofi_command,
	},

	-- List of apps to start once on start-up
	run_on_start_up = {
		-- "picom --config " .. filesystem.get_configuration_dir() .. "/configuration/picom.conf",
		-- "/home/developer/.config/awesome/scripts/autostart.sh",
		-- "nm-applet --indicator", -- wifi
		-- "$HOME/Documents/scripts/screenloyout", -- It's setting in xorg.conf now
		-- "$HOME/Documents/repository/WallpaperChanger/main.py",
		-- "$HOME/Documents/appimages/super-productivity.AppImage",
		-- "numlockx on", -- enable numlock
		-- "nm-applet",

		--FIX: start it every restart awesome
		-- "keepassxc",
		-- "lxpolkit",
		-- "eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)", -- credential manager
		-- "flameshot",
		-- "gammastep",
		--'blueberry-tray', -- Bluetooth tray icon
		-- "/usr/lib/polkit-gnome/polkit-gnome-authentication-agent-1 & eval $(gnome-keyring-daemon -s --components=pkcs11,secrets,ssh,gpg)", -- credential manager
		-- "xfce4-power-manager", -- Power manager
		-- "/usr/bin/variety",

		-- Add applications that need to be killed between reloads
		-- to avoid multipled instances, inside the awspawn script
		-- "~/.config/awesome/configuration/awspawn", -- Spawn "dirty" apps that can linger between sessions
	},
}

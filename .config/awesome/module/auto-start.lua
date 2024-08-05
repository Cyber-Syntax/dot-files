-- MODULE AUTO-START
-- Run all the apps listed in configuration/apps.lua as run_on_start_up only once when awesome start

local awful = require('awful')
local apps = require('configuration.apps')

local function run_once(cmd)
  local findme = cmd
  local firstspace = cmd:find(' ')
  if firstspace then
    findme = cmd:sub(0, firstspace - 1)
  end
  -- this is have limitation for more than 15 characters and awesome give error for that
  --awful.spawn.with_shell(string.format('pgrep -u $USER -x %s > /dev/null || (%s)', findme, cmd))

  -- This is the workaround for the limitation
  awful.spawn.with_shell(string.format('pgrep -u $USER -fx "%s" > /dev/null || (%s)', findme, cmd))
end

for _, app in ipairs(apps.run_on_start_up) do
  run_once(app)
end

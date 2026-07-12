-- Create the hyper alias
local hyper = { "cmd", "alt", "ctrl", "shift" }

-- Reload the config for hammerspoon
hs.hotkey.bind(hyper, "0", function()
  hs.reload()
  hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
end)

-- Bind keys to focus applications
local appKeys = {
  ["1"] = 'XCode',
  ["2"] = 'Safari',
  ["3"] = 'iTerm',
  ["4"] = 'WhatsApp',
  ["5"] = 'Mail'
}
for key, app in pairs(appKeys) do
  hs.hotkey.bind(hyper, key, function()
    hs.application.launchOrFocus(app)
  end)
end

-- Paste My Bosses Name
hs.hotkey.bind(hyper, "d", function()
  hs.eventtap.keyStrokes("Çağatay")
end)

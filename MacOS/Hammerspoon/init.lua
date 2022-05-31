-- Create the hyper alias
local hyper = { "cmd", "alt", "ctrl", "shift" }

-- Reload the config for hammerspoon
hs.hotkey.bind(hyper, "0", function()
  hs.reload()
  hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()
end)

-- Bind keys to focus applications
hs.hotkey.bind(hyper, "1", function()
  hs.application.launchOrFocus('XCode')
end)
hs.hotkey.bind(hyper, "2", function()
  hs.application.launchOrFocus('Safari')
end)
hs.hotkey.bind(hyper, "3", function()
  hs.application.launchOrFocus('iTerm')
end)
hs.hotkey.bind(hyper, "4", function()
  hs.application.launchOrFocus('WhatsApp')
end)
hs.hotkey.bind(hyper, "5", function()
  hs.application.launchOrFocus('Mail')
end)

-- Paste My Bosses Name
hs.hotkey.bind(hyper, "d", function()
  hs.eventtap.keyStrokes("Çağatay")
end)

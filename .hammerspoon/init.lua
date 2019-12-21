-- set up Hyper Key
local hyper = {"cmd", "alt", "ctrl", "shift" }
hs.hotkey.bind(hyper, "0", function()
    hs.reload()
end)

-- set Hyper-0 to reload Hammerspoon config
hs.notify.new({title="Hammerspoon", informativeText="Config loaded"}):send()

-- remove window animations when resizing/moving
hs.window.animationDuration = 0

-- use Hyper-[h|l] to move windows left|right
hs.hotkey.bind(hyper, "h", function()
    local win = hs.window.focusedWindow();
    if not win then return end
win:moveToUnit(hs.layout.left50)
end)

hs.hotkey.bind(hyper, "l", function()
    local win = hs.window.focusedWindow();
    if not win then return end
win:moveToUnit(hs.layout.right50)
end)

-- use Hyper-m to maximize window
hs.hotkey.bind(hyper, "m", function()
    local win = hs.window.focusedWindow();
    if not win then return end
win:moveToUnit(hs.layout.maximized)
end)

-- use Hyper-[j|k] to move to prev|next screen
hs.hotkey.bind(hyper, "j", function()
    local win = hs.window.focusedWindow();
    if not win then return end
win:moveToScreen(win:screen():next())
end)
hs.hotkey.bind(hyper, "k", function()
    local win = hs.window.focusedWindow();
    if not win then return end
win:moveToScreen(win:screen():previous())
end)

-- set up application hotkeys
local applicationHotkeys = {
    b = 'Brave Browser',
    c = 'iTerm',
    f = 'Firefox'
}
for key, app in pairs(applicationHotkeys) do
    hs.hotkey.bind(hyper, key, function()
        hs.application.launchOrFocus(app)
    end)
end

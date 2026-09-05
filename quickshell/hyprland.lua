-- Minimal integration fragment for the new Quickshell build.
-- Merge these rules/binds into the active Hyprland Lua configuration.
local hl = require("hyprland")

hl.config({ decoration = { blur = { enabled = true, size = 8, passes = 4, vibrancy = 0.17 } } })
for _, ns in ipairs({
    "quickshell-bar", "quickshell-dock", "quickshell-holorings",
    "quickshell-notifications", "quickshell-wallpaper-selector"
}) do
    hl.layer_rule({ match = { namespace = ns }, blur = true, ignore_alpha = ns == "quickshell-bar" and 0.08 or 0.2 })
end

local qs = "qs -p /home/kamal/.config/quickshell"
hl.bind("SUPER + SPACE", hl.dsp.exec_cmd(qs .. " ipc call appLauncher toggle"))
hl.bind("SUPER + W", hl.dsp.exec_cmd(qs .. " ipc call wallpaperSelector toggle"))
hl.bind("SUPER + V", hl.dsp.exec_cmd(qs .. " ipc call clipboardHistory toggle"))
hl.bind("CTRL + ALT + T", hl.dsp.exec_cmd(qs .. " ipc call powerMenu toggle"))
hl.bind("SUPER + N", hl.dsp.exec_cmd(qs .. " ipc call notifications toggle"))
hl.bind("CTRL + R", hl.dsp.exec_cmd(qs .. " ipc call screenRecorder toggle"))
hl.bind("CTRL + SHIFT + X", hl.dsp.exec_cmd(qs .. " ipc call screenRecorder stop"))

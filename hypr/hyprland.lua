-- This is an example Hyprland Lua config file.
-- Refer to the wiki for more information.
-- https://wiki.hypr.land/Configuring/Start/

-- Please note not all available settings / options are set here.
-- For a full list, see the wiki

-- You can (and should!!) split this configuration into multiple files
-- Create your files separately and then require them like this:
-- require("myColors")


------------------
---- MONITORS ----
------------------

-- See https://wiki.hypr.land/Configuring/Basics/Monitors/

hl.monitor({
    output   = "",
    mode     = "preferred",
    position = "auto",
    scale    = "1",
})


---------------------
---- MY PROGRAMS ----
---------------------

local terminal    = "kitty"
local fileManager = "dolphin"
local menu        = "hyprlauncher"
local browser     = "qutebrowser"
local music_dir = "$HOME/Music/deeper"
local notes = "obsidian"
local code = "vscodium"
-------------------------------
---- ENVIRONMENT VARIABLES ----
-------------------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/

hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")


-----------------------
---- PERMISSIONS -----
-----------------------

-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Permissions/
-- Please note permission changes here require a Hyprland restart and are not applied on-the-fly
-- for security reasons

-- hl.config({
--   ecosystem = {
--     enforce_permissions = true,
--   },
-- })

-- hl.permission("/usr/(bin|local/bin)/grim", "screencopy", "allow")
-- hl.permission("/usr/(lib|libexec|lib64)/xdg-desktop-portal-hyprland", "screencopy", "allow")
-- hl.permission("/usr/(bin|local/bin)/hyprpm", "plugin", "allow")


-----------------------
---- LOOK AND FEEL ----
-----------------------

-- See https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in  = 2,
        gaps_out = 2,

        border_size = 1,

        col = {
            active_border   = { colors = {"rgba(33ccffee)", "rgba(00ff99ee)"}, angle = 45 },
          inactive_border = "rgba(595959aa)",
        },

        resize_on_border = false,
        allow_tearing = false,
        layout = "dwindle",
    },

    decoration = {
        rounding       = 10,
        rounding_power = 2,

        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = 0xee1a1a1a,
        },

        blur = {
            enabled   = true,
          size      = 3,
          passes    = 1,
          vibrancy  = 0.1696,
        },
    },

    animations = {
        enabled = true,
    },
})


----------------------
---- ANIMATIONS ------
----------------------

hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

hl.curve("easy", {
    type = "spring",
    mass = 1,
    stiffness = 238.1191,
    dampening = 24.21279333
})

hl.animation({ leaf = "global",        enabled = true, speed = 10,   bezier = "default" })
hl.animation({ leaf = "border",        enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows",       enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn",     enabled = true, speed = 4.1,  spring = "easy",   style = "popin 87%" })
hl.animation({ leaf = "windowsOut",    enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn",        enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers",        enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = true, speed = 4,    bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = true, speed = 1.5,  bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces",    enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesIn",  enabled = true, speed = 1.21, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "almostLinear", style = "fade" })
hl.animation({ leaf = "zoomFactor",    enabled = true, speed = 7,    bezier = "quick" })


----------------------
---- RICE / COLORS ---
----------------------

package.loaded["colors-wal"] = nil
pcall(require, "colors-wal")


-----------------------
---- LAYOUTS ----------
-----------------------

hl.config({
    dwindle = {
        preserve_split = true,
    },
})

hl.config({
    master = {
        new_status = "master",
    },
})

hl.config({
    scrolling = {
        fullscreen_on_one_column = true,
    },
})


----------------
---- MISC ------
----------------

hl.config({
    misc = {
        force_default_wallpaper = -1,
            disable_hyprland_logo   = false,
    },
})


---------------
---- INPUT ----
---------------

hl.config({
    input = {
        kb_layout  = "us",
        kb_variant = "",
        kb_model   = "",
        kb_options = "",
        kb_rules   = "",

        follow_mouse = 1,
        sensitivity = 0,

        touchpad = {
            natural_scroll = false,
        },
    },
})

hl.gesture({
    fingers = 3,
    direction = "horizontal",
    action = "workspace"
})

hl.device({
    name        = "epic-mouse-v1",
    sensitivity = -0.5,
})


---------------------
---- KEYBINDINGS ----
---------------------

local mainMod = "SUPER"

local keybinds = require("keybinds")
-- keybinds.setup(mainMod)


-- Applications

hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd(browser))
hl.bind(mainMod .. " + O", hl.dsp.exec_cmd(notes))
hl.bind(mainMod .. " + ALT + O", hl.dsp.exec_cmd(code))
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd(" qs ipc call appLauncher toggle "))
hl.bind("SUPER + ALT + M", hl.dsp.exec_cmd("elisa --directory $HOME/Music/deeper"))
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd(" qs ipc call wallpaperSelector toggle "))
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd(" qs ipc call clipboardHistory toggle "))
hl.bind(mainMod .. " + P", hl.dsp.exec_cmd(" qs ipc call paletteEditor toggle"))
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("qs ipc call modeSwitcher toggle"))




-- Window management

local closeWindowBind = hl.bind(mainMod .. " + Q", hl.dsp.window.close())
-- closeWindowBind:set_enabled(false)

hl.bind(mainMod .. " + P", hl.dsp.window.pseudo())
hl.bind(mainMod .. " + J", hl.dsp.layout("togglesplit"))

hl.bind(mainMod .. " + left",  hl.dsp.focus({ direction = "left" }))
hl.bind(mainMod .. " + right", hl.dsp.focus({ direction = "right" }))
hl.bind(mainMod .. " + up",    hl.dsp.focus({ direction = "up" }))
hl.bind(mainMod .. " + down",  hl.dsp.focus({ direction = "down" }))
hl.bind(mainMod .. " + CTRL + left", hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + CTRL + right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + CTRL + up", hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + CTRL + down", hl.dsp.window.move({ direction = "d" }))


-- Maximize workaround: Toggles layout back and forth cleanly
hl.bind("SUPER + ALT +F", hl.dsp.window.fullscreen({ mode = "maximized", action = "toggle" }))
hl.bind("SUPER + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))




-- Workspaces

hl.bind(mainMod .. " + TAB", hl.dsp.focus({ workspace = "prev" }))
hl.bind(mainMod .. " + ALT + right", hl.dsp.focus({ workspace = "r+1" }))
hl.bind(mainMod .. " + ALT + left", hl.dsp.focus({ workspace = "r-1" }))

hl.bind(mainMod .. " + SHIFT + right", hl.dsp.window.move({ workspace = "r+1" }))
hl.bind(mainMod .. " + SHIFT + left",  hl.dsp.window.move({ workspace = "r-1" }))

for i = 1, 10 do
    local key = i % 10

    hl.bind(mainMod .. " + " .. key,
            hl.dsp.focus({ workspace = i }))

    hl.bind(mainMod .. " + SHIFT + " .. key,
            hl.dsp.window.move({ workspace = i }))
    end


    -- Special workspaces

    hl.bind(mainMod .. " + S",         hl.dsp.workspace.toggle_special("magic"))
    hl.bind(mainMod .. " + SHIFT + S", hl.dsp.window.move({ workspace = "special:magic" }))

    hl.bind(mainMod .. " + A",         hl.dsp.workspace.toggle_special("hidden"))
    hl.bind(mainMod .. " + SHIFT + A", hl.dsp.window.move({ workspace = "special:hidden" }))


    -- Mouse

    hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
    hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

    hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
    hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })


    -- Multimedia

    hl.bind("XF86AudioRaiseVolume",
            hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"),
            { locked = true, repeating = true })

    hl.bind("XF86AudioLowerVolume",
            hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),
            { locked = true, repeating = true })

    hl.bind("XF86AudioMute",
            hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),
            { locked = true, repeating = true })

    hl.bind("XF86AudioMicMute",
            hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),
            { locked = true, repeating = true })

    hl.bind("XF86MonBrightnessUp",
            hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%+"),
            { locked = true, repeating = true })

    hl.bind("XF86MonBrightnessDown",
            hl.dsp.exec_cmd("brightnessctl -e4 -n2 set 5%-"),
            { locked = true, repeating = true })


    -- Media player

    hl.bind("XF86AudioNext",
            hl.dsp.exec_cmd("playerctl next"),
            { locked = true })

    hl.bind("XF86AudioPause",
            hl.dsp.exec_cmd("playerctl play-pause"),
            { locked = true })

    hl.bind("XF86AudioPlay",
            hl.dsp.exec_cmd("playerctl play-pause"),
            { locked = true })

    hl.bind("XF86AudioPrev",
            hl.dsp.exec_cmd("playerctl previous"),
            { locked = true })


    -------------------------------
    ---- BIND OPTIONS -------------
    -------------------------------

    hl.config({
        binds = {
            hide_special_on_workspace_change = true
        }
    })


    --------------------------------
    ---- WINDOWS AND WORKSPACES ----
    --------------------------------

    -- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
    -- and https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/


    -- Window rules

    local suppressMaximizeRule = hl.window_rule({
        name  = "suppress-maximize-events",
        match = { class = ".*" },

        suppress_event = "maximize",
    })

    -- suppressMaximizeRule:set_enabled(false)


    hl.window_rule({
        name = "fix-xwayland-drags",

        match = {
            class      = "^$",
            title      = "^$",
            xwayland   = true,
            float      = true,
            fullscreen = false,
            pin        = false,
        },

        no_focus = true,
    })


    hl.window_rule({
        name  = "move-hyprland-run",
        match = { class = "hyprland-run" },

        move  = "20 monitor_h-120",
        float = true,
    })


    -- Layer rules

    -- local overlayLayerRule = hl.layer_rule({
    --     name = "no-anim-overlay",
--     match = { namespace = "^my-overlay$" },
--     no_anim = true,
-- })
-- overlayLayerRule:set_enabled(false)


-------------------------------
---- AUTOSTART / STARTUP ------
-------------------------------

-- See https://wiki.hypr.land/Configuring/Basics/Autostart/

-- Autostart necessary processes (like notification daemons, status bars, etc.)
-- Or execute your favorite apps at launch like this:
--
-- hl.on("hyprland.start", function ()
--   hl.exec_cmd(terminal)
--   hl.exec_cmd("nm-applet")
--   hl.exec_cmd("waybar & hyprpaper & firefox")
-- end)


hl.on("hyprland.start", function()
hl.exec_cmd("~/.config/quickshell/launch.sh")
end)


--------------------------------
---- VANTAGE BLUR -------------
--------------------------------

-- BEGIN VANTAGE BLUR
-- Added by Vantage's install.sh — safe to edit or remove.

hl.config({
    decoration = {
        blur = {
            enabled = true
        }
    }
})

for _, ns in ipairs({
    "quickshell-bar",
    "quickshell-sysinfo",
    "quickshell-dock",
    "quickshell-holorings",
    "quickshell-bigclock",
    "quickshell-notifications"
}) do
hl.layer_rule({
    match = { namespace = ns },
    blur = true,
    ignore_alpha = 0.2
})
end

hl.layer_rule({
    match = {
        namespace = "quickshell-bar"
    },
    blur = true,
    ignore_alpha = 0.08
})

-- END VANTAGE BLUR

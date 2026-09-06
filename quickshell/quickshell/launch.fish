#!/usr/bin/env fish

cd -- $HOME
set -l SCRIPT_DIR (cd -- (dirname (status --current-filename)); and pwd)

if type -q awww-daemon; and not pgrep -x awww-daemon >/dev/null 2>&1
    awww-daemon >/dev/null 2>&1 &
end

if type -q awww
    for retry in (seq 1 20)
        timeout 0.5s awww query >/dev/null 2>&1; and break
        sleep 0.25
    end
end

if test -x "$SCRIPT_DIR/scripts/restore-wallpaper.fish"
    "$SCRIPT_DIR/scripts/restore-wallpaper.fish" &
end

if type -q wl-paste; and type -q cliphist
    pgrep -f '[w]l-paste --type text --watch cliphist store' >/dev/null 2>&1; or \
        wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
    pgrep -f '[w]l-paste --type image --watch cliphist store' >/dev/null 2>&1; or \
        wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
end

exec qs -p "$SCRIPT_DIR"

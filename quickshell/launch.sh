#!/usr/bin/env bash
set -Eeuo pipefail

cd -- "$HOME"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"

if command -v awww-daemon >/dev/null 2>&1 && ! pgrep -x awww-daemon >/dev/null 2>&1; then
    awww-daemon >/dev/null 2>&1 &
fi

if command -v awww >/dev/null 2>&1; then
    for _ in {1..20}; do
        timeout 0.5s awww query >/dev/null 2>&1 && break
        sleep 0.25
    done
fi

if [[ -x "$SCRIPT_DIR/scripts/restore-wallpaper.sh" ]]; then
    "$SCRIPT_DIR/scripts/restore-wallpaper.sh" &
fi

if command -v wl-paste >/dev/null 2>&1 && command -v cliphist >/dev/null 2>&1; then
    pgrep -f '[w]l-paste --type text --watch cliphist store' >/dev/null 2>&1 || \
        wl-paste --type text --watch cliphist store >/dev/null 2>&1 &
    pgrep -f '[w]l-paste --type image --watch cliphist store' >/dev/null 2>&1 || \
        wl-paste --type image --watch cliphist store >/dev/null 2>&1 &
fi

exec qs -p "$SCRIPT_DIR"

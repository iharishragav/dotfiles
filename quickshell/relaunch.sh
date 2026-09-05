#!/usr/bin/env bash
set -Eeuo pipefail

cd -- "$HOME"
SCRIPT_DIR="$(cd -- "$(dirname -- "${BASH_SOURCE[0]}")" && pwd)"
LOG_FILE="${XDG_RUNTIME_DIR:-/tmp}/quickshell-new.log"

# Stop all Quickshell processes so duplicate bars cannot survive.
pkill -TERM -x quickshell >/dev/null 2>&1 || true
pkill -TERM -x qs >/dev/null 2>&1 || true
sleep 0.8

# Force-clean any process that ignored the graceful signal.
pkill -KILL -x quickshell >/dev/null 2>&1 || true
pkill -KILL -x qs >/dev/null 2>&1 || true

# This is the dedicated user cache for this Quickshell setup.
rm -rf -- "$HOME/.cache/quickshell"
rm -f -- "$LOG_FILE"

nohup "$SCRIPT_DIR/launch.sh" >>"$LOG_FILE" 2>&1 &
disown
printf 'Started quickshell-new; log: %s\n' "$LOG_FILE"

import QtQuick
import Quickshell
import Quickshell.Io
import ".." as Local

// Thin IPC entry point — the actual clipboard UI lives insid
// toggle` works from a keybind.
Item {
    IpcHandler {
        target: "clipboardHistory"
        function toggle(): void { Local.AppState.requestMorph("clipboard"); }
        function open(): void { Local.AppState.requestMorph("clipboard"); }
        function close(): void { Local.AppState.closeMorph(); }
    }
}

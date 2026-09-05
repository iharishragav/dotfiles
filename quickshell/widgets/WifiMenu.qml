import QtQuick
import Quickshell
import Quickshell.Io
import "../core" as Core

Item {
    IpcHandler {
        target: "wifiMenu"
        function toggle(): void { Core.AppState.requestMorph("wifi"); }
        function open(): void { Core.AppState.requestMorph("wifi"); }
        function close(): void { Core.AppState.closeMorph(); }
    }
}

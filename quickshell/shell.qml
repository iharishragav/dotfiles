import Quickshell
import Quickshell.Io
import "core" as Core
import "widgets"

ShellRoot {
    Bar {}
    BarMorph {}
    WallpaperSelector {}
    ClipboardHistory {}
    AppLauncher {}
    Recorder {}
    ArchSymbol{}
    Dock{}
    NotificationCenter{}

    IpcHandler {
        target: "powerMenu"
        function toggle(): void { Core.AppState.requestMorph("power") }
        function open(): void { Core.AppState.requestMorph("power") }
        function close(): void { Core.AppState.closeMorph() }
        function lock(): void { Core.AppState.closeMorph(); Quickshell.execDetached(["hyprlock"]) }
        function suspend(): void { Core.AppState.closeMorph(); Quickshell.execDetached(["systemctl", "suspend"]) }
        function reboot(): void { Core.AppState.closeMorph(); Quickshell.execDetached(["systemctl", "reboot"]) }
        function poweroff(): void { Core.AppState.closeMorph(); Quickshell.execDetached(["systemctl", "poweroff"]) }
    }

    IpcHandler {
        target: "notifications"
        function notify(summary: string, body: string, urgency: string): void {
            Core.AppState.addNotification(summary, body, urgency)
            Core.AppState.notificationDrawerVisible = true
        }
        function clear(): void { Core.AppState.clearNotifications() }
        function toggle(): void {
            Core.AppState.notificationDrawerVisible = !Core.AppState.notificationDrawerVisible
        }
        function open(): void { Core.AppState.notificationDrawerVisible = true }
        function close(): void { Core.AppState.notificationDrawerVisible = false }
    }

    IpcHandler {
        target: "NotificationCenter"
        function toggle(): void {
            Core.AppState.notificationDrawerVisible = !Core.AppState.notificationDrawerVisible
        }
        function open(): void { Core.AppState.notificationDrawerVisible = true }
        function close(): void { Core.AppState.notificationDrawerVisible = false }
    }

    IpcHandler {
        target: "screenRecorder"
        function toggle(): void { Core.AppState.requestMorph("recorder") }
        function open(): void { Core.AppState.requestMorph("recorder") }
        function close(): void { Core.AppState.closeMorph() }
        function start(): void {
            Quickshell.execDetached(["bash", "-c", "mkdir -p \"$HOME/Videos/Recordings\" && gpu-screen-recorder -w screen -f 60 -o \"$HOME/Videos/Recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4\""])
            Core.AppState.requestMorph("recorder")
        }
        function stop(): void {
            Quickshell.execDetached(["bash", "-c", "pkill -SIGINT -x gpu-screen-recorder"])
            Core.AppState.closeMorph()
        }
    }
}

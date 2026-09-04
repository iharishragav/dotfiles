import QtQuick
import Quickshell
import Quickshell.Io
import "../core" as Core

Item {

    IpcHandler {
        target: "recorder"

        function toggle(): void {
            Core.AppState.requestMorph("recorder");
        }

        function open(): void {
            Core.AppState.requestMorph("recorder");
        }

        function close(): void {
            Core.AppState.closeMorph();
        }

        function start(): void {
            Quickshell.execDetached([
                "bash",
                "-c",
                "mkdir -p \"$HOME/Videos/Recordings\" && " +
                "gpu-screen-recorder " +
                "-w screen " +
                "-f 60 " +
                "-o \"$HOME/Videos/Recordings/$(date +%Y-%m-%d_%H-%M-%S).mp4\""
            ]);

            Core.AppState.requestMorph("recorder");
        }

        function stop(): void {
            Quickshell.execDetached([
                "bash",
                "-c",
                "pkill -SIGINT -x gpu-screen-recorder"
            ]);

            Core.AppState.closeMorph();
        }
    }

}
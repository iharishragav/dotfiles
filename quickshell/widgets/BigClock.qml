import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import QtQuick.Window
import QtQuick.Layouts
import "../core" as Core

// Bottom-right desktop clock, translucent card + a progress bar
// under it that fills up with the current minute's seconds.
Variants {
    model: Quickshell.screens

    PanelWindow {
        id: win
        property var modelData
        screen: modelData

        anchors { bottom: true; right: true }
        margins { bottom: 60; right: 20 }

        implicitWidth: content.implicitWidth + 4
        implicitHeight: content.implicitHeight

        color: "transparent"
        WlrLayershell.layer: WlrLayer.Bottom
        WlrLayershell.keyboardFocus: WlrKeyboardFocus.None
        exclusionMode: ExclusionMode.Ignore
        mask: Region {}
        visible: Core.AppState.showDesktopWidgets

        property string hoursMinutes: ""
        property string seconds: ""
        property string dateStr: ""

        function updateClock() {
            const now = new Date();
            win.hoursMinutes = Qt.formatDateTime(now, "hh:mm");
            win.seconds = Qt.formatDateTime(now, "ss");
            win.dateStr = Qt.formatDateTime(now, "ddd, dd MMM yyyy");
        }

        Component.onCompleted: updateClock()

        Timer { interval: 1000; running: true; repeat: true; onTriggered: win.updateClock() }

        Rectangle {
            id: content
            anchors.right: parent.right
            anchors.bottom: parent.bottom
            implicitWidth: col.implicitWidth + 48
            implicitHeight: col.implicitHeight + 32
            radius: 18
            color: Qt.rgba(Core.Colors.background.r, Core.Colors.background.g,
                           Core.Colors.background.b, 0.55)
            border.color: Core.Colors.accent
            border.width: 1

            Column {
                id: col
                anchors.centerIn: parent
                spacing: 6

                Row {
                    anchors.horizontalCenter: parent.horizontalCenter
                    spacing: 6

                    Text {
                        id: timeText
                        text: win.hoursMinutes
                        color: Core.Colors.foreground
                        font.family: Core.Colors.fontFamily
                        font.pixelSize: 56
                        font.weight: Font.Light
                    }

                    Text {
                        anchors.baseline: timeText.baseline
                        text: win.seconds
                        color: Core.Colors.accent
                        font.family: Core.Colors.fontFamily
                        font.pixelSize: 24
                        font.weight: Font.Light
                    }
                }

                Text {
                    anchors.horizontalCenter: parent.horizontalCenter
                    text: win.dateStr
                    color: Core.Colors.muted
                    font.family: Core.Colors.fontFamily
                    font.pixelSize: 14
                }

                Rectangle {
                    anchors.horizontalCenter: parent.horizontalCenter
                    width: col.implicitWidth
                    height: 3
                    radius: 2
                    color: Qt.rgba(Core.Colors.muted.r, Core.Colors.muted.g, Core.Colors.muted.b, 0.3)

                    Rectangle {
                        anchors.left: parent.left
                        height: parent.height
                        radius: 2
                        width: parent.width * (parseInt(win.seconds, 10) / 59)
                        color: Core.Colors.accent

                        Behavior on width {
                            enabled: Core.Colors.animationsEnabled
                            NumberAnimation { duration: 300 }
                        }
                    }
                }
            }
        }
    }
}

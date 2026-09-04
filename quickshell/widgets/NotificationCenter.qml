import Quickshell
import Quickshell.Wayland
import Quickshell.Io
import QtQuick
import "../core" as Core
Item {
    id: root

    IpcHandler {
        target: "notifications"
        function notify(summary: string, body: string, urgency: string) { Core.AppState.addNotification(summary, body, urgency); }
        function clear() { Core.AppState.clearNotifications(); }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            property var modelData
            screen: modelData

            anchors { top: true; right: true }
            margins { top: 56; right: 18 }

            implicitWidth: 360
            implicitHeight: stack.implicitHeight
            color: "transparent"
            visible: Core.AppState.notifications.length > 0

            WlrLayershell.layer: WlrLayer.Overlay
            WlrLayershell.namespace: "quickshell-notifications"
            exclusionMode: ExclusionMode.Ignore

            Column {
                id: stack
                width: parent.width
                spacing: 8

                Repeater {
                    model: Core.AppState.notifications.slice(0, 3)

                    delegate: Rectangle {
                        width: stack.width
                        height: 68
                        radius: 16
                        color: Qt.rgba(Core.Colors.background.r, Core.Colors.background.g, Core.Colors.background.b, .90)
                        border.width: 1
                        border.color: modelData.urgency === "critical" ? "#ff5555" : Core.Colors.accent

                        Column {
                            anchors.fill: parent
                            anchors.margins: 10

                            Text {
                                width: parent.width
                                text: modelData.summary
                                color: Core.Colors.foreground
                                font.bold: true
                                elide: Text.ElideRight
                                font.family: Core.Colors.fontFamily
                            }

                            Text {
                                width: parent.width
                                text: modelData.body
                                color: Core.Colors.muted
                                elide: Text.ElideRight
                                visible: text.length > 0
                                font.family: Core.Colors.fontFamily
                            }
                        }

                        MouseArea {
                            anchors.fill: parent
                            onClicked: Core.AppState.dismissNotification(modelData.id)
                        }
                    }
                }
            }
        }
    }
}

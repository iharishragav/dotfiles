import Quickshell
import Quickshell.Io
import Quickshell.Wayland
import QtQuick
import "../core" as Core

Item {
    id: root

    IpcHandler {
        target: "notifications"

        function toggle(): void {
            Core.AppState.notificationDrawerVisible =
                !Core.AppState.notificationDrawerVisible
        }

        function open(): void {
            Core.AppState.notificationDrawerVisible = true
        }

        function close(): void {
            Core.AppState.notificationDrawerVisible = false
        }
    }

    Variants {
        model: Quickshell.screens

        PanelWindow {
            id: win

            property var modelData

            screen: modelData

            readonly property real screenWidth:
                modelData ? modelData.width : 1920

            readonly property real screenHeight:
                modelData ? modelData.height : 1080

            readonly property int itemHeight: 72
            readonly property int itemSpacing: 4

            readonly property int headerHeight: 32
            readonly property int dividerHeight: 1
            readonly property int clearHeight: 26
            readonly property int contentSpacing: 10
            readonly property int padding: 16

            readonly property int notificationContentHeight:
                Core.AppState.notifications.length > 0
                    ? Core.AppState.notifications.length *
                      (itemHeight + itemSpacing)
                    : 32

            readonly property int wantedHeight:
                padding * 2
                + headerHeight
                + dividerHeight
                + contentSpacing
                + notificationContentHeight
                + contentSpacing
                + clearHeight

            /*
             * 0.75 / 4 = 18.75% of the screen width.
             */
            implicitWidth: screenWidth * 0.1875

            /*
             * Dynamically grow until the bottom of the screen.
             */
            implicitHeight: Math.min(
                wantedHeight,
                screenHeight - 72
            )

            /*
             * Full input surface so clicking outside the
             * notification widget can close it.
             */
            anchors.top: true
            anchors.left: true
            anchors.right: true
            anchors.bottom: true

            margins.top: 56

            visible:
                Core.AppState.notificationDrawerVisible

            color: "transparent"

            WlrLayershell.layer: WlrLayer.Top

            /*
             * Same compositor blur mechanism as Bar.qml.
             */
            WlrLayershell.namespace: "quickshell-bar"

            exclusionMode: ExclusionMode.Ignore

            /*
             * Outside click closes the drawer.
             */
            MouseArea {
                anchors.fill: parent

                onClicked: {
                    Core.AppState.notificationDrawerVisible = false
                }
            }

            Rectangle {
                id: drawer

                anchors.top: parent.top
                anchors.left: parent.left

                width: win.screenWidth * 0.1875
                height: Math.min(
                    win.wantedHeight,
                    win.screenHeight - 72
                )

                /*
                 * FIX:
                 * Do not use height / 2.
                 * That created the huge circular overlap.
                 */
                radius: 20

                color: Qt.rgba(
                    Core.Colors.background.r,
                    Core.Colors.background.g,
                    Core.Colors.background.b,
                    0.14
                )

                border.color: Core.Colors.accent
                border.width: 1

                /*
                 * Prevent the outside-click MouseArea
                 * from receiving clicks inside the drawer.
                 */
                MouseArea {
                    anchors.fill: parent
                    onClicked: mouse => mouse.accepted = true
                }

                focus: true

                Component.onCompleted: {
                    forceActiveFocus()
                }

                Keys.onEscapePressed: {
                    Core.AppState.notificationDrawerVisible = false
                    event.accepted = true
                }

                Column {
                    anchors.fill: parent
                    anchors.margins: 16

                    spacing: 10

                    /*
                     * =========================
                     * HEADER
                     * =========================
                     */

                    Item {
                        width: parent.width
                        height: 32

                        Text {
                            anchors.centerIn: parent

                            text: "NOTIFICATIONS"

                            color: Core.Colors.accent

                            font.family:
                                Core.Colors.fontFamily

                            font.bold: true
                            font.letterSpacing: 2
                        }

                        Text {
                            anchors.right: parent.right
                            anchors.verticalCenter: parent.verticalCenter

                            text:
                                "" +
                                Core.AppState.notifications.length

                            color: Core.Colors.muted

                            font.family:
                                Core.Colors.fontFamily
                        }
                    }

                    /*
                     * =========================
                     * DIVIDER
                     * =========================
                     */

                    Rectangle {
                        width: parent.width
                        height: 1

                        color: Core.Colors.accent
                        opacity: 0.35
                    }

                    /*
                     * =========================
                     * NOTIFICATIONS
                     * =========================
                     */

                    ListView {
                        id: list

                        width: parent.width

                        /*
                         * Fill only the space remaining
                         * between header and CLEAR ALL.
                         */
                        LayoutMirroring.enabled: false

                        height: Math.max(
                            32,
                            parent.height
                            - 32
                            - 1
                            - 10
                            - 10
                            - 26
                        )

                        visible:
                            Core.AppState.notifications.length > 0

                        clip: true

                        spacing: itemSpacing

                        model:
                            Core.AppState.notifications

                        delegate: Rectangle {
                            width: list.width
                            height: itemHeight

                            radius: 12

                            color: Qt.rgba(
                                1,
                                1,
                                1,
                                0.05
                            )

                            border.color:
                                modelData.urgency === "critical"
                                    ? "#ff5555"
                                    : Core.Colors.accent

                            border.width: 1

                            Column {
                                anchors.fill: parent
                                anchors.margins: 10

                                Text {
                                    width: parent.width

                                    text:
                                        modelData.summary

                                    color:
                                        Core.Colors.foreground

                                    font.family:
                                        Core.Colors.fontFamily

                                    font.bold: true

                                    elide:
                                        Text.ElideRight
                                }

                                Text {
                                    width: parent.width

                                    text:
                                        modelData.body

                                    color:
                                        Core.Colors.muted

                                    font.family:
                                        Core.Colors.fontFamily

                                    wrapMode:
                                        Text.Wrap

                                    maximumLineCount: 2

                                    elide:
                                        Text.ElideRight
                                }
                            }

                            MouseArea {
                                anchors.fill: parent

                                onClicked:
                                    Core.AppState.dismissNotification(
                                        modelData.id
                                    )
                            }
                        }
                    }

                    /*
                     * =========================
                     * CLEAR ALL
                     * =========================
                     */

                    Rectangle {
                        visible:
                            Core.AppState.notifications.length > 0

                        anchors.horizontalCenter: parent.horizontalCenter

                        /*
                         * Reduced widget size.
                         */
                        width: 90
                        height: 26

                        radius: 13

                        color: Qt.rgba(
                            1,
                            1,
                            1,
                            0.05
                        )

                        border.color: Core.Colors.accent
                        border.width: 1

                        Text {
                            anchors.centerIn: parent

                            text: "CLEAR ALL"

                            color: Core.Colors.accent

                            font.family:
                                Core.Colors.fontFamily

                            font.pixelSize: 9
                            font.bold: true
                            font.letterSpacing: 1
                        }

                        MouseArea {
                            anchors.fill: parent

                            onClicked: {
                                Core.AppState.clearNotifications()
                            }
                        }
                    }
                }
            }
        }
    }
}

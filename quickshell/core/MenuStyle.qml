pragma Singleton
import QtQuick

QtObject {
    readonly property color panelColor: Qt.rgba(Colors.background.r, Colors.background.g, Colors.background.b, 0.92)
    readonly property color borderColor: Colors.accent
    readonly property color textColor: Colors.foreground
    readonly property color mutedColor: Colors.muted
    readonly property color accentColor: Colors.accent
    readonly property color overlayColor: "#000000"
    readonly property real overlayOpacity: 0.45
    readonly property int radius: 16
    readonly property int borderWidth: 1
    readonly property string namespace: "quickshell-bar"
}

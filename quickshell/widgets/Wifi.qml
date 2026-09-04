import Quickshell
import Quickshell.Services.Networking
import QtQuick
import QtQuick.Layouts
import "../core" as Core

Item {
    id: wifiRoot
    anchors.fill: parent

    // Properties for state tracking
    property bool showOnlySaved: false
    property bool showMore: false

    // Password modal / prompt state
    property WifiNetwork targetNetwork: null
    property string pskPassword: ""
    property string pskErrorMsg: ""

    // Find the first active Wi-Fi device from Quickshell.Networking
    readonly property WifiDevice wifiDevice: {
        if (typeof Networking === "undefined" || !Networking.devices) return null;
        for (let i = 0; i < Networking.devices.length; i++) {
            const dev = Networking.devices[i];
            if (dev && dev.type === DeviceType.Wifi) {
                return dev;
            }
        }
        return null;
    }

    // Process and sort network list according to requirements
    readonly property var processedNetworks: {
        if (!wifiDevice || !wifiDevice.networks) return { connected: null, others: [], totalRemainingCount: 0 };

        const rawList = [];
        for (let i = 0; i < wifiDevice.networks.length; i++) {
            const net = wifiDevice.networks[i];
            if (!net) continue;
            if (showOnlySaved && !net.known) continue;
            rawList.push(net);
        }

        // Find connected network if any
        let connectedNet = null;
        const remainingNets = [];

        for (let i = 0; i < rawList.length; i++) {
            const net = rawList[i];
            if (net.connected && !connectedNet) {
                connectedNet = net;
            } else {
                remainingNets.push(net);
            }
        }

        // Sort remaining networks by signalStrength descending
        remainingNets.sort((a, b) => (b.signalStrength || 0) - (a.signalStrength || 0));

        // Apply initial limit (up to 3 remaining networks) unless showMore is true
        const visibleRemaining = showMore ? remainingNets : remainingNets.slice(0, 3);

        return {
            connected: connectedNet,
            others: visibleRemaining,
            totalRemainingCount: remainingNets.length
        };
    }

    // Dynamic Nerd Font icon helper based on signalStrength (0.0 to 1.0 or 0 to 100)
    function getWifiIcon(signal, connected) {
        const pct = signal > 1 ? signal : Math.round(signal * 100);

        if (pct >= 75) return "\uf1eb";      // Full signal
        else if (pct >= 50) return "\uf0930"; // Good signal
        else if (pct >= 25) return "\uf092f"; // Medium signal
        else return "\uf092e";                // Weak signal
    }

    function handleNetworkClick(net) {
        if (!net) return;
        pskErrorMsg = "";

        if (net.connected) {
            return;
        }

        if (net.known) {
            // Known network: connect directly using native API
            if (typeof net.connect === "function") {
                net.connect();
            }
        } else {
            // Secured unknown network: password required
            targetNetwork = net;
            pskPassword = "";
        }
    }

    ColumnLayout {
        anchors.fill: parent
        spacing: 6

        // Top control bar: Small side controls [↻] [▣] […] at top-right
        RowLayout {
            Layout.fillWidth: true
            Layout.preferredHeight: 24
            spacing: 6

            Text {
                text: "Wi-Fi"
                color: Core.Colors.foreground
                font.family: Core.Colors.fontFamily
                font.pixelSize: 12
                font.bold: true
                Layout.verticalAlignment: Qt.AlignVCenter
            }

            Item { Layout.fillWidth: true }

            // 1. Refresh Button [↻] (22x22)
            Rectangle {
                width: 22
                height: 22
                radius: 11
                color: refreshMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.06)
                border.width: 1
                border.color: refreshMouse.containsMouse ? Core.Colors.accent : Qt.rgba(1, 1, 1, 0.1)

                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "\uf021" // Refresh glyph
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 11
                    color: Core.Colors.foreground
                }

                MouseArea {
                    id: refreshMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: {
                        if (wifiDevice && typeof wifiDevice.scan === "function") {
                            wifiDevice.scan();
                        }
                    }
                }
            }

            // 2. Saved Filter Button [▣] (22x22)
            Rectangle {
                width: 22
                height: 22
                radius: 11
                color: showOnlySaved
                       ? Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.35)
                       : (savedMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.06))
                border.width: 1
                border.color: showOnlySaved ? Core.Colors.accent : (savedMouse.containsMouse ? Core.Colors.accent : Qt.rgba(1, 1, 1, 0.1))

                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "\uf0c7" // Saved/Bookmark glyph
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 11
                    color: Core.Colors.foreground
                }

                MouseArea {
                    id: savedMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: showOnlySaved = !showOnlySaved
                }
            }

            // 3. More Button […] (22x22)
            Rectangle {
                width: 22
                height: 22
                radius: 11
                color: showMore
                       ? Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.35)
                       : (moreMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.06))
                border.width: 1
                border.color: showMore ? Core.Colors.accent : (moreMouse.containsMouse ? Core.Colors.accent : Qt.rgba(1, 1, 1, 0.1))

                Behavior on color { ColorAnimation { duration: 120 } }

                Text {
                    anchors.centerIn: parent
                    text: "\uf141" // Ellipsis glyph
                    font.family: "Symbols Nerd Font"
                    font.pixelSize: 11
                    color: Core.Colors.foreground
                }

                MouseArea {
                    id: moreMouse
                    anchors.fill: parent
                    hoverEnabled: true
                    onClicked: showMore = !showMore
                }
            }
        }

        // Inline Password Entry View (if requesting password)
        ColumnLayout {
            id: pskBox
            Layout.fillWidth: true
            visible: targetNetwork !== null
            spacing: 6

            Text {
                text: targetNetwork ? ("Connect to " + (targetNetwork.ssid || targetNetwork.name || "Network")) : ""
                color: Core.Colors.foreground
                font.family: Core.Colors.fontFamily
                font.pixelSize: 11
            }

            Rectangle {
                Layout.fillWidth: true
                height: 30
                radius: 15
                color: Qt.rgba(1, 1, 1, 0.08)
                border.color: Core.Colors.accent
                border.width: 1

                TextInput {
                    id: pwdInput
                    anchors.fill: parent
                    anchors.leftMargin: 12
                    anchors.rightMargin: 12
                    verticalAlignment: TextInput.AlignVCenter
                    echoMode: TextInput.Password
                    color: Core.Colors.foreground
                    font.family: Core.Colors.fontFamily
                    font.pixelSize: 11
                    clip: true
                    text: pskPassword
                    onTextChanged: pskPassword = text

                    Keys.onReturnPressed: submitPsk()
                    Keys.onEnterPressed: submitPsk()
                    Keys.onEscapePressed: targetNetwork = null
                }
            }

            RowLayout {
                Layout.fillWidth: true
                spacing: 8

                Item { Layout.fillWidth: true }

                Rectangle {
                    width: 60
                    height: 24
                    radius: 12
                    color: cancelMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.15) : Qt.rgba(1, 1, 1, 0.06)

                    Text {
                        anchors.centerIn: parent
                        text: "Cancel"
                        color: Core.Colors.muted
                        font.family: Core.Colors.fontFamily
                        font.pixelSize: 10
                    }

                    MouseArea {
                        id: cancelMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: targetNetwork = null
                    }
                }

                Rectangle {
                    width: 65
                    height: 24
                    radius: 12
                    color: connectBtnMouse.containsMouse ? Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.5)
                                                         : Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.3)

                    Text {
                        anchors.centerIn: parent
                        text: "Connect"
                        color: Core.Colors.foreground
                        font.family: Core.Colors.fontFamily
                        font.pixelSize: 10
                        font.bold: true
                    }

                    MouseArea {
                        id: connectBtnMouse
                        anchors.fill: parent
                        hoverEnabled: true
                        onClicked: submitPsk()
                    }
                }
            }
        }

        function submitPsk() {
            if (!targetNetwork) return;
            if (typeof targetNetwork.connectWithPsk === "function") {
                targetNetwork.connectWithPsk(pskPassword);
            } else if (typeof targetNetwork.connect === "function") {
                targetNetwork.connect(pskPassword);
            }
            targetNetwork = null;
            pskPassword = "";
        }

        // Wi-Fi Horizontal List View
        Flickable {
            Layout.fillWidth: true
            Layout.fillHeight: true
            contentWidth: netRow.implicitWidth
            contentHeight: height
            flickableDirection: Flickable.HorizontalFlick
            clip: true
            visible: targetNetwork === null

            RowLayout {
                id: netRow
                anchors.verticalCenter: parent.verticalCenter
                height: parent.height
                spacing: 8

                // Connected network first (if present)
                Item {
                    id: connectedItem
                    visible: processedNetworks.connected !== null
                    Layout.fillHeight: true
                    width: 80

                    readonly property var net: processedNetworks.connected

                    Rectangle {
                        id: connBtn
                        anchors.fill: parent
                        radius: 10

                        color: connMouse.containsMouse
                               ? Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.40)
                               : Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.25)
                        border.width: 1
                        border.color: Core.Colors.accent

                        Behavior on color { ColorAnimation { duration: 120 } }

                        Column {
                            anchors.centerIn: parent
                            spacing: 4
                            width: parent.width - 8

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: net ? getWifiIcon(net.signalStrength, true) : "\uf1eb"
                                font.family: "Symbols Nerd Font"
                                font.pixelSize: 18
                                color: Core.Colors.accent
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width
                                text: net ? (net.ssid || net.name || "Connected") : ""
                                font.family: Core.Colors.fontFamily
                                font.pixelSize: 10
                                font.bold: true
                                color: Core.Colors.foreground
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }
                        }

                        MouseArea {
                            id: connMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: handleNetworkClick(net)
                        }
                    }
                }

                // Visual separator after connected network
                Rectangle {
                    visible: processedNetworks.connected !== null && processedNetworks.others.length > 0
                    Layout.preferredWidth: 1
                    Layout.fillHeight: true
                    Layout.topMargin: 8
                    Layout.bottomMargin: 8
                    color: Qt.rgba(Core.Colors.accent.r, Core.Colors.accent.g, Core.Colors.accent.b, 0.4)
                }

                // Remaining networks
                Repeater {
                    model: processedNetworks.others

                    delegate: Rectangle {
                        id: netBtn
                        Layout.fillHeight: true
                        Layout.preferredWidth: 80
                        radius: 10

                        readonly property var net: modelData

                        color: netMouse.containsMouse ? Qt.rgba(1, 1, 1, 0.12) : "transparent"

                        Behavior on color { ColorAnimation { duration: 120 } }

                        Column {
                            anchors.centerIn: parent
                            spacing: 4
                            width: parent.width - 8

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                text: net ? getWifiIcon(net.signalStrength, false) : "\uf1eb"
                                font.family: "Symbols Nerd Font"
                                font.pixelSize: 18
                                color: net && net.known ? Core.Colors.accent : Core.Colors.foreground
                            }

                            Text {
                                anchors.horizontalCenter: parent.horizontalCenter
                                width: parent.width
                                text: net ? (net.ssid || net.name || "Wi-Fi") : ""
                                font.family: Core.Colors.fontFamily
                                font.pixelSize: 10
                                color: Core.Colors.muted
                                horizontalAlignment: Text.AlignHCenter
                                elide: Text.ElideRight
                            }
                        }

                        MouseArea {
                            id: netMouse
                            anchors.fill: parent
                            hoverEnabled: true
                            onClicked: handleNetworkClick(net)
                        }
                    }
                }
            }
        }
    }
}

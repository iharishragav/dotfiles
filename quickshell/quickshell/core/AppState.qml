pragma Singleton
import QtQuick
import Quickshell
import Quickshell.Io

QtObject {
    id: root
    property bool showBar: true
    property bool showDesktopWidgets: true
    // Compatibility name for callers that still use the old panel property.
    // The morph mode is the single shared surface state.
    property alias activePanel: root.barMorph
    property var notifications: []
    property var todos: []
    property int notificationSerial: 0
    property bool notificationDrawerVisible: false

    property string barMorph: ""
    property real morphOriginX: 0
    property real morphOriginY: 0
    property real morphOriginWidth: 0
    property real morphOriginHeight: 0
    property real morphScreenHeight: 1080
    property string morphScreenName: ""
    property bool barTemporarilyHidden: false
    property Timer barHideTimer: Timer {
        interval: 1600
        repeat: false
        onTriggered: root.barTemporarilyHidden = false
    }

    signal morphRequested(string name)
    signal morphClosed(string screenName)

    property Process todoReader: Process {
        command: ["python3", Quickshell.shellDir + "/scripts/todo-store.py", "read"]
        stdout: StdioCollector {
            onStreamFinished: root.applyTodos(this.text)
        }
    }
    property Process todoMutation: Process {
        command: ["true"]
        stdout: StdioCollector {
            onStreamFinished: root.loadTodos()
        }
    }

    Component.onCompleted: root.loadTodos()

    function loadTodos() {
        todoReader.running = false
        todoReader.running = true
    }

    function applyTodos(raw) {
        try {
            const parsed = JSON.parse(raw || "[]")
            todos = Array.isArray(parsed) ? parsed : []
        } catch (error) {
            console.warn("TodoBoard: failed to parse todo store", error)
            todos = []
        }
    }

    function checkTodo(id) {
        todoMutation.command = ["python3", Quickshell.shellDir + "/scripts/todo-store.py", "check", "--id", String(id)]
        todoMutation.running = true
    }

    function markTodoNotified(id) {
        todoMutation.command = ["python3", Quickshell.shellDir + "/scripts/todo-store.py", "notify", "--id", String(id)]
        todoMutation.running = true
    }

    function openMorph(name, originX, originY, originWidth, originHeight, screenName, screenHeight) {
        morphOriginX = originX
        morphOriginY = originY
        morphOriginWidth = originWidth
        morphOriginHeight = originHeight
        morphScreenName = screenName
        morphScreenHeight = screenHeight
        barMorph = name
    }
    function closeMorph() { barMorph = "" }
    function requestMorph(name) { morphRequested(name) }
    function runPowerAction(action) {
        let command = ["true"]
        if (action === "lock") command = ["hyprlock"]
        else if (action === "sleep") command = ["systemctl", "suspend"]
        else if (action === "reboot") command = ["systemctl", "reboot"]
        else if (action === "shutdown") command = ["systemctl", "poweroff"]
        closeMorph()
        Quickshell.execDetached(command)
    }
    function hideBarTemporarily(ms) {
        barHideTimer.interval = ms
        barTemporarilyHidden = true
        barHideTimer.restart()
    }

    function openPanel(name) { activePanel = name }
    function closePanel() { activePanel = "" }
    function addNotification(summary, body, urgency) {
        const item = { id: ++notificationSerial, summary: String(summary || "Notification"), body: String(body || ""), urgency: String(urgency || "normal") }
        notifications = [item].concat(notifications).slice(0, 50)
    }
    function dismissNotification(id) { notifications = notifications.filter(item => item.id !== id) }
    function clearNotifications() { notifications = []; notificationDrawerVisible = false }
}

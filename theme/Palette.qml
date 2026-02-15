pragma Singleton
import QtQuick

QtObject {
    property color bg: "#1a1b26"
    property color fg: "#a9b1d6"
    property color accent: "#7aa2f7"
    property color urgent: "#f7768e"
    property color muted: "#414868"
    property color workspaceActive: "#3d59a1"
    property color workspaceFocused: "#7aa2f7"
    property color workspaceInactive: "#24283b"

    property int fontSize: 13
    property string fontFamily: "sans-serif"
}
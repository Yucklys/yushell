import QtQuick
import QtQuick.Layouts
import Quickshell
import Niri 0.1
import "root:theme" as Theme

Row {
    id: root
    spacing: 2

    required property var monitor

    Niri {
        id: niri
        Component.onCompleted: connect()

        onConnected: console.log("Connected to niri, screen:", root.monitor.name)
    }

    Repeater {
        model: niri.workspaces

        Rectangle {
            id: workspace

            required property var modelData

            width: 28
            height: 20
            radius: 3
            visible: modelData.output === root.monitor.name

            color: modelData.isFocused ? Theme.Palette.workspaceFocused :
                   modelData.isActive ? Theme.Palette.workspaceActive :
                   Theme.Palette.workspaceInactive

            border.width: modelData.isUrgent ? 2 : 0
            border.color: Theme.Palette.urgent

            Text {
                anchors.centerIn: parent
                text: modelData.name || modelData.index
                color: Theme.Palette.fg
                font.pixelSize: Theme.Palette.fontSize
                font.family: Theme.Palette.fontFamily
                font.bold: modelData.isFocused
            }

            MouseArea {
                anchors.fill: parent
                hoverEnabled: true

                onClicked: niri.focusWorkspaceById(modelData.id)

                onEntered: workspace.color = Qt.lighter(workspace.color, 1.2)
                onExited: {
                    workspace.color = modelData.isFocused ? Theme.Palette.workspaceFocused :
                                   modelData.isActive ? Theme.Palette.workspaceActive :
                                   Theme.Palette.workspaceInactive
                }
            }
        }
    }
}

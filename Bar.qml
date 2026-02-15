import Quickshell
import Quickshell.Wayland
import QtQuick
import QtQuick.Layouts
import "widgets" as Widgets
import "theme" as Theme

PanelWindow {
    id: root

    anchors {
        top: true
        left: true
        right: true
    }

    implicitHeight: 30
    color: Theme.Palette.bg

    RowLayout {
        anchors.fill: parent
        anchors.leftMargin: 8
        anchors.rightMargin: 8
        spacing: 8

        Widgets.Workspaces { monitor: root.screen }

        Item {
            Layout.fillWidth: true
        }

        Widgets.Clock {}
    }
}
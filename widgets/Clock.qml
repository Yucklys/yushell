import QtQuick
import Quickshell
import "root:theme" as Theme

Item {
    id: root

    implicitWidth: timeText.implicitWidth
    implicitHeight: timeText.implicitHeight

    SystemClock {
        id: clock
        precision: SystemClock.Seconds
    }

    Text {
        id: timeText
        text: Qt.formatDateTime(clock.date, "HH:mm")
        color: Theme.Palette.fg
        font.pixelSize: Theme.Palette.fontSize
        font.family: Theme.Palette.fontFamily
    }
}

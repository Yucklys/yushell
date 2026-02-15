import Quickshell
import "root:."

ShellRoot {
    Variants {
        model: Quickshell.screens

        Bar {
            required property var modelData
            screen: modelData
        }
    }
}
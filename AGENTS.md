# AGENTS.md

Guidelines for agentic coding agents working in this repository.

## Project Overview

YANS (Yet-Another-Niri-Shell) is a minimal system bar for the Niri Wayland compositor, built with Quickshell (QML/Qt).

## Build and Development Commands

```bash
just run      # Direct run (foreground)
just start    # Start tmux session (recommended)
just logs     # View recent output
just stop     # Kill session
just build    # nix build
just update   # nix flake update
```

Debug logs: `/run/user/1000/quickshell/by-id/<shell-id>/log.qslog`

## Project Structure

```
yans/
├── shell.qml          # Entry point - ShellRoot with Variants
├── Bar.qml            # PanelWindow definition
├── widgets/           # Widget components (Workspaces, Clock)
├── theme/Palette.qml  # Singleton color/font definitions
├── flake.nix          # Nix flake
└── justfile           # Build/run commands
```

## Code Style Guidelines

### Import Order

```qml
// 1. Qt/Quickshell modules
import QtQuick
import QtQuick.Layouts
import Quickshell
import Quickshell.Wayland

// 2. Third-party modules (with version)
import Niri 0.1

// 3. Local imports (with namespace)
import "widgets" as Widgets
import "root:theme" as Theme
```

### Naming Conventions

- **Files**: PascalCase (`Workspaces.qml`)
- **IDs**: lowercase (`id: root`)
- **Properties**: camelCase (`implicitWidth`)
- **Handlers**: `onConnected`, `onClicked`

### Component Structure

```qml
Item {
    id: root

    // 1. Required properties
    required property var monitor

    // 2. Internal properties
    property int value: 0

    // 3. Services
    Niri { id: niri; Component.onCompleted: connect() }

    // 4. Visual children
    Row { }

    // 5. Signal handlers
    Component.onCompleted: { }
}
```

### Property Types

```qml
property color bg: "#1a1b26"
property int fontSize: 13
property string fontFamily: "sans-serif"
required property var modelData
```

### Theme Usage

Reference theme via singleton, never hardcode colors:

```qml
color: Theme.Palette.bg
font.pixelSize: Theme.Palette.fontSize
```

### Multi-Monitor

Filter workspace data by monitor:

```qml
required property var monitor
visible: modelData.output === root.monitor.name
```

### Error Handling

```qml
text: modelData.name || modelData.index  // Fallback
property var items: niri.workspaces.values ? [...niri.workspaces.values] : []
```

### Async Services

```qml
Niri {
    id: niri
    Component.onCompleted: connect()
    onConnected: { /* safe to access niri.workspaces */ }
}
```

### Mouse Interactions

```qml
MouseArea {
    hoverEnabled: true
    onEntered: parent.color = Qt.lighter(parent.color, 1.2)
    onExited: parent.color = originalColor
}
```

## Dependencies

| Dependency | Purpose |
|------------|---------|
| quickshell | Qt/QML shell framework |
| qml-niri | Niri IPC (workspaces, windows) |

No external CLI tools required.

## Common Patterns

```qml
// Workspace filtering
Repeater {
    model: niri.workspaces
    delegate: Rectangle {
        visible: modelData.output === root.monitor.name
    }
}

// SystemClock
SystemClock { id: clock; precision: SystemClock.Seconds }
Text { text: Qt.formatDateTime(clock.date, "HH:mm") }
```

## Notes

- System bar only - no launchers, notifications, or theme management
- Target: Niri (scrollable tiling Wayland compositor)
- Must work across multiple monitors with independent workspace sets
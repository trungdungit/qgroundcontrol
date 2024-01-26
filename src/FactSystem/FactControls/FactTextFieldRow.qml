import QtQuick              2.12
import QtQuick.Controls     1.2
import QtQuick.Dialogs      1.2
import QtQuick.Layouts      1.2

import QGroundControl               1.0
import QGroundControl.FactSystem    1.0
import QGroundControl.FactControls  1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.Controllers   1.0
import QGroundControl.ScreenTools   1.0

RowLayout {
    property var fact: Fact { }

    QGCLabel {
        text: fact.name + ":"
    }

    FactTextField {
        Layout.fillWidth:   true
        showUnits:          true
        fact:               parent.fact
    }
}

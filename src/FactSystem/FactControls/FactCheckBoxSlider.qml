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

QGCCheckBoxSlider {
    property Fact fact: Fact { }

    property var checkedValue:   fact.typeIsBool ? true : 1
    property var uncheckedValue: fact.typeIsBool ? false : 0

    Binding on checked {
        value: fact ?
                (fact.value === uncheckedValue ? Qt.Unchecked : Qt.Checked) :
                Qt.Unchecked
    }

    onClicked: fact.value = (checked ? checkedValue : uncheckedValue)
}

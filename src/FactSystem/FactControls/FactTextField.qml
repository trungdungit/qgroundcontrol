import QtQuick                  2.3
import QtQuick.Controls         2.12
import QtQuick.Controls.Styles  1.4
import QtQuick.Dialogs          1.2

import QGroundControl.FactSystem    1.0
import QGroundControl.Palette       1.0
import QGroundControl.Controls      1.0
import QGroundControl.ScreenTools   1.0

QGCTextField {
    id: control

    text:               fact ? fact.valueString : ""
    unitsLabel:         fact ? fact.units : ""
    showUnits:          true
    showHelp:           false
    numericValuesOnly:  fact && !fact.typeIsString

    signal updated()

    property Fact   fact: null

    property string _validateString

    onEditingFinished: {
        var errorString = fact.validate(text, false /* convertOnly */)
        if (errorString === "") {
            globals.validationError = false
            validationToolTip.visible = false
            fact.value = text
            control.updated()
        } else {
            globals.validationError = true
            validationToolTip.text = errorString
            validationToolTip.visible = true
        }
    }

    onHelpClicked: helpDialogComponent.createObject(mainWindow).open()

    ToolTip {
        id: validationToolTip

        QGCMouseArea {
            anchors.fill: parent
            onClicked: {
                control.text = fact.valueString
                validationToolTip.visible = false
                globals.validationError = false
            }
        }
    }

    Component {
        id: validationErrorDialogComponent

        ParameterEditorDialog {
            title:          qsTr("Invalid Value")
            validate:       true
            validateValue:  _validateString
            fact:           control.fact
        }
    }

    Component {
        id: helpDialogComponent

        ParameterEditorDialog {
            title:          qsTr("Value Details")
            fact:           control.fact
        }
    }
}

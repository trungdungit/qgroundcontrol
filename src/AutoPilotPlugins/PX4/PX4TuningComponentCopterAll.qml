/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

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

PX4TuningComponent {
    model: ListModel {
        ListElement { 
            buttonText: qsTr("Rate Controller")
            tuningPage: "PX4TuningComponentCopterRate.qml"
        }
        ListElement { 
            buttonText: qsTr("Attitude Controller")
            tuningPage: "PX4TuningComponentCopterAttitude.qml"
        }
        ListElement { 
            buttonText: qsTr("Velocity Controller")
            tuningPage: "PX4TuningComponentCopterVelocity.qml"
        }
        ListElement { 
            buttonText: qsTr("Position Controller")
            tuningPage: "PX4TuningComponentCopterPosition.qml"
        }
    }
}

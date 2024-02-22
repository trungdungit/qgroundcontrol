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

Item {

    FactPanelController { id: controller; }

    // Use default component id
    TextInput {
        objectName: "testControl"
        text:       fact1.value

        property Fact fact1: controller.getParameterFact(-1, "RC_MAP_THROTTLE")

        onAccepted: fact1.value = text
    }

    // Use specific component id
    TextInput {
        text:       fact2.value

        property Fact fact2: controller.getParameterFact(1, "RC_MAP_THROTTLE")

        onAccepted: fact2.value = text
    }
}

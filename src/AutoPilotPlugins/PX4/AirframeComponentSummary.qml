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
    anchors.fill:       parent

    AirframeComponentController { id: controller; }

    property Fact sysIdFact:        controller.getParameterFact(-1, "MAV_SYS_ID")
    property Fact sysAutoStartFact: controller.getParameterFact(-1, "SYS_AUTOSTART")

    property bool autoStartSet: sysAutoStartFact ? (sysAutoStartFact.value !== 0) : false

    Column {
        anchors.fill:       parent
        VehicleSummaryRow {
            labelText: qsTr("System ID")
            valueText: sysIdFact ? sysIdFact.valueString : ""
        }
        VehicleSummaryRow {
            labelText: qsTr("Airframe type")
            valueText: autoStartSet ? controller.currentAirframeType : qsTr("Setup required")
        }
        VehicleSummaryRow {
            labelText: qsTr("Vehicle")
            valueText: autoStartSet ? controller.currentVehicleName : qsTr("Setup required")
        }

        VehicleSummaryRow {
            labelText: qsTr("Firmware Version")
            valueText: globals.activeVehicle.firmwareMajorVersion === -1 ? qsTr("Unknown") : globals.activeVehicle.firmwareMajorVersion + "." + globals.activeVehicle.firmwareMinorVersion + "." + globals.activeVehicle.firmwarePatchVersion + globals.activeVehicle.firmwareVersionTypeString
        }
        VehicleSummaryRow {
            visible: globals.activeVehicle.firmwareCustomMajorVersion !== -1
            labelText: qsTr("Custom Fw. Ver.")
            valueText: globals.activeVehicle.firmwareCustomMajorVersion + "." + globals.activeVehicle.firmwareCustomMinorVersion + "." + globals.activeVehicle.firmwareCustomPatchVersion
        }
    }
}

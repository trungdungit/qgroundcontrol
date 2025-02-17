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
    anchors.fill:   parent

    FactPanelController { id: controller; }

    property Fact frameFact: controller.getParameterFact(-1, "FRAME_CONFIG")

    function frameName() {
        switch(frameFact.value) {
        case 0:
            return "BlueROV1"
        case 1:
            return "Vectored/BlueROV2"
        case 2:
            return "Vectored 6DOF"
        case 3:
            return "Vectored 6DOF 90Degree"
        case 4:
            return "SimpleROV-3"
        case 5:
            return "SimpleROV-4"
        case 6:
            return "SimpleROV-5"
        case 7:
            return "Custom"
        default:
            return "Unknown"
        }
    }

    Column {
        anchors.fill:       parent
        VehicleSummaryRow {
            id: nameRow;
            labelText: qsTr("Frame Type")
            valueText: frameName()
        }

        VehicleSummaryRow {
            labelText: qsTr("Firmware Version")
            valueText: globals.activeVehicle.firmwareMajorVersion == -1 ? qsTr("Unknown") : globals.activeVehicle.firmwareMajorVersion + "." + globals.activeVehicle.firmwareMinorVersion + "." + globals.activeVehicle.firmwarePatchVersion + " " + globals.activeVehicle.firmwareVersionTypeString
        }

        VehicleSummaryRow {
            labelText: qsTr("Git Revision")
            valueText: globals.activeVehicle.gitHash == -1 ? qsTr("Unknown") : globals.activeVehicle.gitHash
        }
    }
}

/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.3
import QtQuick.Controls 1.2
import QtQuick.Layouts  1.11

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

//-------------------------------------------------------------------------
//-- Multiple Vehicle Selector
QGCComboBox {
    anchors.verticalCenter: parent.verticalCenter
    font.pointSize:         ScreenTools.mediumFontPointSize
    currentIndex:           -1
    sizeToContents:         true
    model:                  _vehicleModel

    property bool showIndicator: _multipleVehicles

    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property bool   _multipleVehicles:  QGroundControl.multiVehicleManager.vehicles.count > 1
    property var    _vehicleModel:      [ ]

    Connections {
        target:         QGroundControl.multiVehicleManager.vehicles
        onCountChanged:  _updateVehicleModel()
    }

    Component.onCompleted:      _updateVehicleModel()
    on_ActiveVehicleChanged:    _updateVehicleModel()

    function _updateVehicleModel() {
        var newCurrentIndex = -1
        var newModel = [ ]
        if (_multipleVehicles) {
            for (var i = 0; i < QGroundControl.multiVehicleManager.vehicles.count; i++) {
                var vehicle = QGroundControl.multiVehicleManager.vehicles.get(i)
                newModel.push(qsTr("Vehicle") + " " + vehicle.id)

                if (vehicle.id === _activeVehicle.id) {
                    newCurrentIndex = i
                }
            }
        }
        currentIndex = -1
        _vehicleModel = newModel
        currentIndex = newCurrentIndex
    }

    onActivated: {
        var vehicleId = textAt(index).split(" ")[1]
        var vehicle = QGroundControl.multiVehicleManager.getVehicleById(vehicleId)
        QGroundControl.multiVehicleManager.activeVehicle = vehicle
    }
}


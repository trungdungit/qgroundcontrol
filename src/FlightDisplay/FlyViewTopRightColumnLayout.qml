/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick 2.3
import QtQuick.Layouts 1.2

import QGroundControl 1.0
import QGroundControl.Controls 1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap 1.0
import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0

ColumnLayout {
    Layout.fillHeight: true

    ColumnLayout {
        Layout.alignment:   Qt.AlignTop
        Layout.fillHeight:  false
        spacing:            parent.spacing

        RowLayout {
            id:                 multiVehiclePanelSelector
            Layout.fillWidth:   false
            Layout.fillHeight:  false
            spacing:            ScreenTools.defaultFontPixelWidth
            visible:            QGroundControl.multiVehicleManager.vehicles.count > 1 && QGroundControl.corePlugin.options.flyView.showMultiVehicleList

            QGCMapPalette { id: mapPal; lightColors: true }

            QGCRadioButton {
                id:             singleVehicleRadio
                text:           qsTr("Single")
                checked:        _showSingleVehicleUI
                onClicked:      _showSingleVehicleUI = true
                textColor:      mapPal.text
            }

            QGCRadioButton {
                text:           qsTr("Multi-Vehicle")
                textColor:      mapPal.text
                onClicked:      _showSingleVehicleUI = false
            }
        }

        ColumnLayout {
            Layout.fillHeight:      false
            Layout.preferredWidth:  _rightPanelWidth
            spacing:                parent.spacing
            visible:                _showSingleVehicleUI

            TerrainProgress {
                Layout.fillWidth: true
            }

            PhotoVideoControl {
                id:                     photoVideoControl
                Layout.fillWidth:       true

                property real rightEdgeCenterInset: visible ? parent.width - x : 0
            }
        }
    }

    MultiVehicleList {
        Layout.preferredWidth:  _rightPanelWidth
        Layout.fillHeight:      true
        visible:                !_showSingleVehicleUI
    }
}

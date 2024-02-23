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
//-- Telemetry RSSI
Item {
    id:             control
    anchors.top:    parent.top
    anchors.bottom: parent.bottom
    width:          telemIcon.width * 1.1

    property bool showIndicator: true //_hasTelemetry

    property var  _activeVehicle:   QGroundControl.multiVehicleManager.activeVehicle
    property bool _hasTelemetry:    _activeVehicle ? _activeVehicle.telemetryLRSSI !== 0 : false

    QGCColoredImage {
        id:                 telemIcon
        anchors.top:        parent.top
        anchors.bottom:     parent.bottom
        width:              height
        sourceSize.height:  height
        source:             "/qmlimages/TelemRSSI.svg"
        fillMode:           Image.PreserveAspectFit
        color:              qgcPal.buttonText
    }
    MouseArea {
        anchors.fill:   parent
        onClicked:      mainWindow.showIndicatorDrawer(telemRSSIInfoPage, control)
    }

    Component {
        id: telemRSSIInfoPage

        ToolIndicatorPage {
            showExpand: false

            contentComponent: Component {
                ColumnLayout {
                    spacing: ScreenTools.defaultFontPixelHeight / 2

                    SettingsGroupLayout {
                        heading: qsTr("Telemetry RSSI Status")

                        LabelledLabel {
                            label:      qsTr("Local RSSI:")
                            labelText:  _activeVehicle.telemetryLRSSI + " " + qsTr("dBm")
                        }

                        LabelledLabel {
                            label:      qsTr("Remote RSSI:")
                            labelText:  _activeVehicle.telemetryRRSSI + " " + qsTr("dBm")
                        }

                        LabelledLabel {
                            label:      qsTr("RX Errors:")
                            labelText:  _activeVehicle.telemetryRXErrors
                        }

                        LabelledLabel {
                            label:      qsTr("Errors Fixed:")
                            labelText:  _activeVehicle.telemetryFixed
                        }

                        LabelledLabel {
                            label:      qsTr("TX Buffer:")
                            labelText:  _activeVehicle.telemetryTXBuffer
                        }

                        LabelledLabel {
                            label:      qsTr("Local Noise:")
                            labelText:  _activeVehicle.telemetryLNoise
                        }

                        LabelledLabel {
                            label:      qsTr("Remote Noise:")
                            labelText:  _activeVehicle.telemetryRNoise
                        }
                    }
                }
            }
        }
    }
}

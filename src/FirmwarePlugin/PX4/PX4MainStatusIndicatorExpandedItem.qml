/****************************************************************************
 *
 * (c) 2009-2022 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick              2.12
import QtQuick.Layouts      1.2

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

ColumnLayout {
    spacing: ScreenTools.defaultFontPixelHeight / 2

    FactPanelController { id: controller }

    SettingsGroupLayout {
        heading:            qsTr("Ground Control Data Link Loss")
        Layout.fillWidth:   true

        RowLayout {
            Layout.fillWidth: true
            spacing:          ScreenTools.defaultFontPixelWidth * 2

            QGCLabel {
                Layout.fillWidth:   true;
                text:               qsTr("Failsafe Action")
            }
            FactComboBox {
                id:                     failsafeActionCombo
                fact:                   controller.getParameterFact(-1, "NAV_DLL_ACT")
                indexModel:             false
            }
        }

        LabelledFactSlider {
            Layout.fillWidth:       true
            label:                  qsTr("Data Link Loss Timeout")
            fact:                   controller.getParameterFact(-1, "COM_DL_LOSS_T")
            sliderPreferredWidth:   ScreenTools.defaultFontPixelWidth * 20
        }
    }

    SettingsGroupLayout {
        Layout.fillWidth: true

        GridLayout {
            columns:            2
            rowSpacing:         ScreenTools.defaultFontPixelHeight / 2
            columnSpacing:      ScreenTools.defaultFontPixelWidth *2
            Layout.fillWidth:   true

            QGCLabel { Layout.fillWidth: true; text: qsTr("Vehicle Parameters") }
            QGCButton {
                text: qsTr("Configure")
                onClicked: {                            
                    mainWindow.showVehicleSetupTool(qsTr("Parameters"))
                    drawer.close()
                }
            }

            QGCLabel { Layout.fillWidth: true; text: qsTr("Initial Vehicle Setup") }
            QGCButton {
                text: qsTr("Configure")
                onClicked: {                            
                    mainWindow.showVehicleSetupTool()
                    drawer.close()
                }
            }
        }
    }
}

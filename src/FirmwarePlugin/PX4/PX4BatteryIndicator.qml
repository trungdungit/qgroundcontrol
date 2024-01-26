/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
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
import MAVLink                              1.0

BatteryIndicator {
    waitForParameters: true

    expandedPageComponent: Component {
        SettingsGroupLayout {
            Layout.fillWidth:   true
            heading:            qsTr("Low Battery")

            FactPanelController { id: controller }

            LabelledFactSlider {
                Layout.fillWidth:       true
                Layout.preferredWidth:  ScreenTools.defaultFontPixelWidth * 20
                label:                  qsTr("Warning Level")
                fact:                   controller.getParameterFact(-1, "BAT_LOW_THR")
            }   

            LabelledFactSlider {
                Layout.fillWidth:   true
                label:              qsTr("Failsafe Level")
                fact:               controller.getParameterFact(-1, "BAT_CRIT_THR")
            }

            LabelledFactSlider {
                Layout.fillWidth:   true
                label:              qsTr("Emergency Level")
                fact:               controller.getParameterFact(-1, "BAT_EMERGEN_THR")
            }

            LabelledFactComboBox {
                label:              qsTr("Failsafe Action")
                fact:               controller.getParameterFact(-1, "COM_LOW_BAT_ACT")
                indexModel:         false
            }
        }
    }
}

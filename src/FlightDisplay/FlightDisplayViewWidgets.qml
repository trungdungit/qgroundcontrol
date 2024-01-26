/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/
import QtQuick          2.12
import QtQuick.Controls 2.12

import QGroundControl               1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap     1.0
import QGroundControl.ScreenTools   1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.Vehicle       1.0
import QGroundControl.Controllers   1.0

Loader {
    width:  parent.width
    source: QGroundControl.settingsManager.flyViewSettings.alternateInstrumentPanel.rawValue ?
                "qrc:/qml/QGCInstrumentWidgetAlternate.qml" : "qrc:/qml/QGCInstrumentWidget.qml"

    property var missionController
}

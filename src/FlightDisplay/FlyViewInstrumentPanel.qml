/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.12
import QtQuick.Layouts  1.3
import QtQuick.Controls 2.12
import QtQuick.Dialogs  1.2

import QGroundControl               1.0
import QGroundControl.Controllers   1.0
import QGroundControl.Controls      1.0
import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0

// This control contains the instruments as well and the instrument pages which include values, camera, ...
ColumnLayout {
    id:         _root
    spacing:    _toolsMargin
    z:          QGroundControl.zOrderWidgets

    property real availableHeight

    SelectableControl {
        selectionUIRightAnchor: true
        selectedControl:        QGroundControl.settingsManager.flyViewSettings.instrumentQmlFile

        property var missionController: _missionController
    }

    TerrainProgress {
        Layout.fillWidth: true
    }
}

/****************************************************************************
 *
 * (c) 2009-2022 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick 2.12
import QtQuick.Layouts 1.12

import QGroundControl.Controls 1.0
import QGroundControl.ScreenTools 1.0

RowLayout {
    property alias label:                   label.text
    property alias model:                   _comboBox.model
    property var   comboBox:                _comboBox
    property real  comboBoxPreferredWidth:  -1

    spacing: ScreenTools.defaultFontPixelWidth * 2

    signal activated(int index)

    QGCLabel {
        id:                 label  
        Layout.fillWidth:   true
    }

    QGCComboBox {
        id:                     _comboBox
        Layout.preferredWidth:  comboBoxPreferredWidth
        onActivated: (index) => { parent.activated(index) }
    }
}

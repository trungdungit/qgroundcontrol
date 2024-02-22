/****************************************************************************
 *
 * (c) 2009-2024 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3

import QGroundControl.ScreenTools 1.0
import QGroundControl.Palette 1.0
import QGroundControl.FactSystem 1.0
import QGroundControl.FactControls 1.0

/// Controt that allows the user to select from a list of controls to display.
/// Selection is is shown on right-click for desktop and long press for mobile.
Control {
    id:             control
    topInset:       0
    bottomInset:    0
    leftInset:      0
    rightInset:     0
    topPadding:     _showSelectionUI ? selectionUILayout.height : 0
    bottomPadding:  0
    leftPadding:    0
    rightPadding:   0

    property Fact selectedControl               ///< Fact which has enumStrings/Values where values are the qml file for the control
    property bool selectionUIRightAnchor: false
    property var  innerControl:           loader.item

    property bool _showSelectionUI: false

    background: Item {
        RowLayout {
            id:             selectionUILayout
            anchors.right:  control.selectionUIRightAnchor ? parent.right : undefined
            spacing:        ScreenTools.defaultFontPixelWidth
            visible:        _showSelectionUI

            FactComboBox {
                fact:           selectedControl
                indexModel:     false
                sizeToContents: true
            }

            QGCButton {
                text:       qsTr("X")
                onClicked:  _showSelectionUI = false
            }
        }
    }

    contentItem: Item {
        implicitWidth:  loader.item.width
        implicitHeight: loader.item.height

        Loader {
            id:     loader
            source: selectedControl ? selectedControl.rawValue : ""
        }

        QGCMouseArea {
            anchors.fill:       parent
            acceptedButtons:    Qt.LeftButton | Qt.RightButton

            onClicked: (mouse) => {
                if (!ScreenTools.isMobile && mouse.button === Qt.RightButton) {
                    _showSelectionUI = true
                }
            }

            onPressAndHold: {
                if (ScreenTools.isMobile) {
                    _showSelectionUI = true
                }
            }
        }
    }
}

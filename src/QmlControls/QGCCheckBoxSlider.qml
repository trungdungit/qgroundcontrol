/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                  2.3
import QtQuick.Controls         1.2
import QtQuick.Layouts          1.12

import QGroundControl.Palette       1.0
import QGroundControl.ScreenTools   1.0

Button   {
    id:             control
    checkable:      true
//    padding:        0

//    QGCPalette { id: qgcPal; colorGroupEnabled: control.enabled }

//    contentItem: Item {
//        implicitWidth:  (label.visible ? label.contentWidth + ScreenTools.defaultFontPixelWidth : 0) + indicator.width
//        implicitHeight: label.contentHeight

//        QGCLabel {
//            id:             label
//            anchors.left:   parent.left
//            text:           visible ? control.text : "X"
//            visible:        control.text !== ""
//        }
    
//        Rectangle {
//            id:                     indicator
//            anchors.right:          parent.right
//            anchors.verticalCenter: parent.verticalCenter
//            height:                 ScreenTools.defaultFontPixelHeight
//            width:                  height * 2
//            radius:                 height / 2
//            color:                  control.checked ? qgcPal.primaryButton : qgcPal.button

//            Rectangle {
//                anchors.verticalCenter: parent.verticalCenter
//                x:                      checked ? indicator.width - width - 1: 1
//                height:                 parent.height - 2
//                width:                  height
//                radius:                 height / 2
//                color:                  qgcPal.buttonText
//            }
//        }
//    }
}

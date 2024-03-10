/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick          2.11
import QtQuick.Layouts  1.11

import QGroundControl                       1.0
import QGroundControl.Controls              1.0
import QGroundControl.MultiVehicleManager   1.0
import QGroundControl.ScreenTools           1.0
import QGroundControl.Palette               1.0
import QGroundControl.FactSystem            1.0
import QGroundControl.FactControls          1.0

Item {
    anchors.top:    parent.top
    anchors.bottom: parent.bottom
    width:          linkCombo.width

    property bool showIndicator: false

    property var    _activeVehicle:     QGroundControl.multiVehicleManager.activeVehicle
    property var    _rgLinkNames:       _activeVehicle ? _activeVehicle.vehicleLinkManager.linkNames : [ ]
    property var    _rgLinkStatus:      _activeVehicle ? _activeVehicle.vehicleLinkManager.linkStatuses : [ ]
    property string _primaryLinkName:   _activeVehicle ? _activeVehicle.vehicleLinkManager.primaryLinkName : ""

    function updateComboModel() {
        var linkModel = []
        for (var i = 0; i < _rgLinkNames.length; i++) {
            var linkStatus = _rgLinkStatus[i]
            linkModel.push(_rgLinkNames[i] + (linkStatus === "" ? "" : " " + _rgLinkStatus[i]))
        }

        linkCombo.model = linkModel
        linkCombo.currentIndex = -1
        showIndicator = _rgLinkNames.length > 1
    }

    Component.onCompleted:  updateComboModel()
    on_RgLinkNamesChanged:  updateComboModel()
    on_RgLinkStatusChanged: updateComboModel()

    QGCComboBox {
        id:             linkCombo
        sizeToContents: true
        alternateText:  _primaryLinkName
        onActivated:    (index) => { _activeVehicle.vehicleLinkManager.primaryLinkName = _rgLinkNames[index]; currentIndex = -1 }
    }
}

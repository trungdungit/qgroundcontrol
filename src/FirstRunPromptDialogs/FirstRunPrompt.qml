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

// Base class for all first run prompt dialogs
QGCPopupDialog {
    buttons: Dialog.Ok

    property int  promptId
    property bool markAsShownOnClose: true

    onClosed: {
        if (markAsShownOnClose) {
            QGroundControl.settingsManager.appSettings.firstRunPromptIdsMarkIdAsShown(promptId)
        }
    }
}

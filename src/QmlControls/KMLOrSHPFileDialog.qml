/****************************************************************************
 *
 * (c) 2009-2020 QGROUNDCONTROL PROJECT <http://www.qgroundcontrol.org>
 *
 * QGroundControl is licensed according to the terms in the file
 * COPYING.md in the root of the source code directory.
 *
 ****************************************************************************/

import QtQuick                          2.11

import QGroundControl                   1.0
import QGroundControl.Controls          1.0
import QGroundControl.ShapeFileHelper   1.0

QGCFileDialog {
    id:             kmlOrSHPLoadDialog
    folder:         QGroundControl.settingsManager.appSettings.missionSavePath
    title:          qsTr("Select Polygon File")
    nameFilters:    ShapeFileHelper.fileDialogKMLOrSHPFilters
}

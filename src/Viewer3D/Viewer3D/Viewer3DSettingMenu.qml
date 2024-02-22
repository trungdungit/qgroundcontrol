import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2

import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0
import QGroundControl.Controls 1.0

import QGroundControl.Viewer3D 1.0

///     @author Omid Esrafilian <esrafilian.omid@gmail.com>

Rectangle {

    signal menuClosed(bool accept)

    property var viewer3DManager: null
    property int leftMarginSpace: ScreenTools.defaultFontPixelWidth

    id: window_body
    clip: true
    color: qgcPal.window
    visible: true
    width: Screen.width * 0.25
    height: Screen.width * 0.15

    QGCPalette {
        id:                 qgcPal
        colorGroupEnabled:  enabled
    }

    QGCLabel {
        id: map_file_label
        Layout.fillWidth:   true
        wrapMode:           Text.WordWrap
        visible:            true
        text: qsTr("3D Map File:")
        anchors.left: parent.left
        anchors.top: parent.top
        anchors.leftMargin: leftMarginSpace
        anchors.topMargin: ScreenTools.defaultFontPixelWidth * 3
    }

    QGCButton {
        id: map_file_btn
        anchors.right: map_file_text_feild.right
        anchors.top: map_file_text_feild.bottom
        anchors.topMargin: ScreenTools.defaultFontPixelWidth * 2
        anchors.rightMargin: ScreenTools.defaultFontPixelWidth

        visible:    true
        text:       qsTr("Select File")

        onClicked: {
            fileDialog.openForLoad()
        }

        QGCFileDialog {
            id:             fileDialog

            nameFilters:    [qsTr("OpenStreetMap files (*.osm)")]
            title:          qsTr("Select map file")
            onAcceptedForLoad: (file) => {
                                   map_file_text_feild.text = file
                               }
        }
    }

    QGCTextField {
        id:                 map_file_text_feild
        height:             ScreenTools.defaultFontPixelWidth * 4.5
        unitsLabel:         ""
        showUnits:          false
        visible:            true

        anchors.verticalCenter: map_file_label.verticalCenter
        anchors.right: parent.right
        anchors.left: map_file_label.right
        anchors.rightMargin: 20
        anchors.leftMargin: 20
        readOnly: true

        text: (viewer3DManager)?(viewer3DManager.viewer3DSetting.osmFilePath.rawValue):("nan")
    }

    QGCLabel {
        id: bld_level_height
        Layout.fillWidth:   true
        wrapMode:           Text.WordWrap
        visible:            true
        text: qsTr("Average Building Level Height:")
        anchors.left: parent.left
        anchors.top: map_file_btn.bottom
        anchors.leftMargin: leftMarginSpace
        anchors.topMargin: ScreenTools.defaultFontPixelWidth * 2
    }

    QGCTextField {
        id:                 bld_level_height_textfeild
        width:              ScreenTools.defaultFontPixelWidth * 15
        unitsLabel:         "m"
        showUnits:          true
        numericValuesOnly:  true
        visible:            true

        anchors.verticalCenter: bld_level_height.verticalCenter
        anchors.left:           bld_level_height.right
        anchors.leftMargin:     ScreenTools.defaultFontPixelWidth * 2

        text: (viewer3DManager)?(Number(viewer3DManager.viewer3DSetting.buildingLevelHeight.rawValue)):("nan")

        validator: RegExpValidator{
            regExp: /(-?\d{1,10})([.]\d{1,6})?$/
        }

        onAccepted:
        {
            focus = false
        }
    }

    QGCLabel {
        id: height_bias_label
        Layout.fillWidth:   true
        wrapMode:           Text.WordWrap
        visible:            true
        text: qsTr("Vehicles Altitude Bias:")
        anchors.left: parent.left
        anchors.top: bld_level_height.bottom
        anchors.leftMargin: leftMarginSpace
        anchors.topMargin: ScreenTools.defaultFontPixelWidth * 4
    }

    QGCTextField {
        id:                 height_bias_textfeild
        width:              ScreenTools.defaultFontPixelWidth * 15
        unitsLabel:         "m"
        showUnits:          true
        numericValuesOnly:  true
        visible:            true

        anchors.verticalCenter: height_bias_label.verticalCenter
        anchors.left:           height_bias_label.right
        anchors.leftMargin:     ScreenTools.defaultFontPixelWidth * 2

        text: (viewer3DManager)?(Number(viewer3DManager.viewer3DSetting.altitudeBias.rawValue)):("nan")

        validator: RegExpValidator{
            regExp: /(-?\d{1,10})([.]\d{1,6})?$/
        }

        onAccepted:
        {
            focus = false
        }
    }

    onMenuClosed: function (accept){
        if(accept === true){
            viewer3DManager.qmlBackend.osmFilePath = map_file_text_feild.text
            viewer3DManager.qmlBackend.altitudeBias = parseFloat(height_bias_textfeild.text)

            viewer3DManager.viewer3DSetting.osmFilePath.rawValue = map_file_text_feild.text
            viewer3DManager.viewer3DSetting.buildingLevelHeight.rawValue = parseFloat(bld_level_height_textfeild.text)
            viewer3DManager.viewer3DSetting.altitudeBias.rawValue = parseFloat(height_bias_textfeild.text)

            viewer3DManager.osmParser.buildingLevelHeight = parseFloat(bld_level_height_textfeild.text)
        }
    }
}

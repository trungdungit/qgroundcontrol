import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Dialogs 1.2
import QtQuick.Layouts 1.2

import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0
import QGroundControl.Controls 1.0

// 3D Viewer modules
import QGroundControl 1.0
import QGroundControl.SettingsManager 1.0
import QGroundControl.Viewer3D 1.0
import Viewer3D.Models3D 1.0

///     @author Omid Esrafilian <esrafilian.omid@gmail.com>

Item{
    id: viewer3DBody
    property bool isOpen: false
    property bool   _viewer3DEnabled:        QGroundControl.settingsManager.viewer3DSettings.enabled.rawValue


    function open(){
        if(_viewer3DEnabled === true){
            view3DManagerLoader.sourceComponent = viewer3DManagerComponent
            view3DManagerLoader.active = true;
            viewer3DBody.z = 1
            isOpen = true;
        }
    }

    function close(){
        viewer3DBody.z = 0
        isOpen = false;
    }

    on_Viewer3DEnabledChanged: {
        if(_viewer3DEnabled === false){
            viewer3DBody.close();
            view3DLoader.active = false;
            view3DManagerLoader.active = false;
        }
    }

    Component{
        id: viewer3DManagerComponent

        Viewer3DManager{
            id: _viewer3DManager
        }
    }

    Loader{
        id: view3DManagerLoader

        onLoaded: {
            view3DLoader.source = "Models3D/Viewer3DModel.qml"
            view3DLoader.active = true;
        }
    }

    Loader{
        id: view3DLoader
        anchors.fill: parent

        onLoaded: {
            item.viewer3DManager = view3DManagerLoader.item
        }
    }

    Binding{
        target: view3DLoader.item
        property: "isViewer3DOpen"
        value: isOpen
        when: view3DLoader.status == Loader.Ready
    }
}

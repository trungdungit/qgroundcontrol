import QtQuick3D 1.15
import QtQuick 2.3
import QtQuick.Controls 2.3
import QtQuick.Window 2.3

import Viewer3D.Models3D.Drones 1.0
import Viewer3D.Models3D 1.0
import QGroundControl.Viewer3D 1.0

import QGroundControl 1.0
import QGroundControl.Controllers 1.0
import QGroundControl.Controls 1.0
import QGroundControl.FlightDisplay 1.0
import QGroundControl.FlightMap 1.0
import QGroundControl.Palette 1.0
import QGroundControl.ScreenTools 1.0
import QGroundControl.Vehicle 1.0

///     @author Omid Esrafilian <esrafilian.omid@gmail.com>

View3D {
    id: topView
    property var viewer3DManager: null
    readonly property var _gpsRef: viewer3DManager.qmlBackend.gpsRef
    property bool isViewer3DOpen: false
    property real rotationSpeed: 0.1
    property real movementSpeed: 1
    property real zoomSpeed: 0.3

    function rotateCamera(newPose: vector2d, lastPose: vector2d) {
        let rotation_vec = Qt.vector2d(newPose.y - lastPose.y, newPose.x - lastPose.x);

        let dx_l = rotation_vec.x * rotationSpeed
        let dy_l = rotation_vec.y * rotationSpeed

        standAloneScene.cameraOneRotation.x += dx_l
        standAloneScene.cameraOneRotation.y += dy_l
    }

    function moveCamera(newPose: vector2d, lastPose: vector2d) {
        let _roll = standAloneScene.cameraOneRotation.x * (3.1415/180)
        let _pitch = standAloneScene.cameraOneRotation.y * (3.1415/180)

        let dx_l = (newPose.x - lastPose.x) * movementSpeed
        let dy_l = (newPose.y - lastPose.y) * movementSpeed

        //Note: Rotation Matrix is computed as: R = R(-_pitch) * R(_roll)
        // Then the corerxt tramslation is: d = R * [dx_l; dy_l; dz_l]

        let dx = dx_l * Math.cos(_pitch) - dy_l * Math.sin(_pitch) * Math.sin(_roll)
        let dy =  dy_l * Math.cos(_roll)
        let dz = dx_l * Math.sin(_pitch) + dy_l * Math.cos(_pitch) * Math.sin(_roll)

        standAloneScene.cameraTwoPosition.x -= dx
        standAloneScene.cameraTwoPosition.y += dy
        standAloneScene.cameraTwoPosition.z += dz
    }

    function zoomCamera(zoomValue){
        let dz_l = zoomValue * zoomSpeed;

        let _roll = standAloneScene.cameraOneRotation.x * (3.1415/180)
        let _pitch = standAloneScene.cameraOneRotation.y * (3.1415/180)

        let dx = -dz_l * Math.cos(_roll) * Math.sin(_pitch)
        let dy =  -dz_l * Math.sin(_roll)
        let dz = dz_l * Math.cos(_pitch) * Math.cos(_roll)

        standAloneScene.cameraTwoPosition.x -= dx
        standAloneScene.cameraTwoPosition.y += dy
        standAloneScene.cameraTwoPosition.z += dz
    }

    on_GpsRefChanged:{
        standAloneScene.resetCamera();
    }

    camera: standAloneScene.cameraOne
    importScene: CameraLightModel{
        id: standAloneScene
    }

    //    renderMode: View3D.Inline

    environment: SceneEnvironment {
        clearColor: "#F9F9F9"
        backgroundMode: SceneEnvironment.Color
    }

    Model {
        id: cityMapModel
        visible: true
        scale: Qt.vector3d(10, 10, 10)
        geometry: CityMapGeometry {
            id: cityMapGeometry
            modelName: "city_map"
            osmParser: (viewer3DManager)?(viewer3DManager.osmParser):(null)
        }

        materials: [
            PrincipledMaterial {
                baseColor: "gray"
                metalness: 0.1
                roughness: 0.5
                specularAmount: 1.0
                indexOfRefraction: 4.0
                opacity: 1.0
            }
        ]
    }

    Component{
        id: vehicle3DComponent
        Repeater3D{
            model: QGroundControl.multiVehicleManager.vehicles

            delegate: Viewer3DVehicleItems{
                _vehicle: object
                _backendQml: (viewer3DManager)?(viewer3DManager.qmlBackend):(null)
                _planMasterController: masterController

                PlanMasterController {
                    id: masterController
                    Component.onCompleted: startStaticActiveVehicle(object)
                }
            }
        }
    }

    Loader3D{
        id: vehicle3DLoader
    }

    onViewer3DManagerChanged: {
        vehicle3DLoader.sourceComponent = vehicle3DComponent
    }

    MouseArea{
        property real _transferSpeed: 1
        property real _rotationSpeed: 0.1
        property real _zoomSpeed: 0.3
        property point _lastPose;

        anchors.fill: parent
        acceptedButtons: Qt.AllButtons;


        onPressed: (mouse)=> {
                       _lastPose = Qt.point(mouse.x, mouse.y);
                   }

        onPositionChanged: (mouse)=> {
                               let _roll = standAloneScene.cameraOneRotation.x * (3.1415/180)
                               let _pitch = standAloneScene.cameraOneRotation.y * (3.1415/180)
                               //            let yaw = standAloneScene.cameraOneRotation.z * (3.1415/180)

                               if (mouse.buttons === Qt.LeftButton) { // Left button for translate
                                   let dx_l = (mouse.x - _lastPose.x) * _transferSpeed
                                   let dy_l = (mouse.y - _lastPose.y) * _transferSpeed

                                   //Note: Rotation Matrix is computed as: R = R(-_pitch) * R(_roll)
                                   // Then the corerxt tramslation is: d = R * [dx_l; dy_l; dz_l]

                                   let dx = dx_l * Math.cos(_pitch) - dy_l * Math.sin(_pitch) * Math.sin(_roll)
                                   let dy =  dy_l * Math.cos(_roll)
                                   let dz = dx_l * Math.sin(_pitch) + dy_l * Math.cos(_pitch) * Math.sin(_roll)

                                   standAloneScene.cameraTwoPosition.x -= dx
                                   standAloneScene.cameraTwoPosition.y += dy
                                   standAloneScene.cameraTwoPosition.z += dz
                               }else if (mouse.buttons === Qt.RightButton){ // Right button for rotation

                                   let rotation_vec = Qt.vector2d(mouse.y - _lastPose.y, mouse.x - _lastPose.x);

                                   let dx_l = rotation_vec.x * _rotationSpeed
                                   let dy_l = rotation_vec.y * _rotationSpeed

                                   standAloneScene.cameraOneRotation.x += dx_l
                                   standAloneScene.cameraOneRotation.y += dy_l

                               }
                               _lastPose = Qt.point(mouse.x, mouse.y)
                           }

        onWheel: (wheel)=> {
                     let dz_l = -wheel.angleDelta.y * _zoomSpeed

                     let _roll = standAloneScene.cameraOneRotation.x * (3.1415/180)
                     let _pitch = standAloneScene.cameraOneRotation.y * (3.1415/180)

                     let dx = -dz_l * Math.cos(_roll) * Math.sin(_pitch)
                     let dy =  -dz_l * Math.sin(_roll)
                     let dz = dz_l * Math.cos(_pitch) * Math.cos(_roll)

                     standAloneScene.cameraTwoPosition.x -= dx
                     standAloneScene.cameraTwoPosition.y += dy
                     standAloneScene.cameraTwoPosition.z += dz
                 }
    }
}

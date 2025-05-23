import QtQuick3D 1.15
import QtQuick 2.3
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

Node {
    id: vehicel3DBody
    property var  _backendQml:                  null
    property var  _vehicle:                     null
    property var  _planMasterController:        null
    property var  _missionController:           (_planMasterController)?(_planMasterController.missionController):(null)
    property var _viewer3DSetting:              QGroundControl.settingsManager.viewer3DSettings
    property var _altitudeBias:                 _viewer3DSetting.altitudeBias.rawValue


    function addMissionItemsToListModel() {
        missionWaypointListModel.clear()
        var _geo2EnuCopy = goe2Enu

        for (var i = 1; i < _missionController.visualItems.count; i++) {
            var _missionItem = _missionController.visualItems.get(i); // list of all properties in VisualMissionItem.h and SimpleMissionItem.h
            if(_missionItem.specifiesCoordinate){
                _geo2EnuCopy.coordinate = _missionItem.coordinate;
                _geo2EnuCopy.coordinate.altitude = 0;
                missionWaypointListModel.append({
                                                    "x": _geo2EnuCopy.localCoordinate.x,
                                                    "y": _geo2EnuCopy.localCoordinate.y,
                                                    "z": _missionItem.altitude.value,
                                                    "abbreviation": _missionItem.abbreviation,
                                                    "index": _missionItem.sequenceNumber,
                                                });
            }
        }
    }

    function addSegmentToMissionPathModel() {
        missionPathModel.clear()
        var _geo2EnuCopy = goe2Enu

        var _missionItemPrevious = _missionController.visualItems.get(1)
        for (var i = 2; i < _missionController.visualItems.count; i++) {
            var _missionItem = _missionController.visualItems.get(i)
            if(_missionItem.abbreviation !== "ROI" && _missionItem.specifiesCoordinate){
                _geo2EnuCopy.coordinate = _missionItemPrevious.coordinate;
                _geo2EnuCopy.coordinate.altitude = 0;
                var p1 = Qt.vector3d(_geo2EnuCopy.localCoordinate.x, _geo2EnuCopy.localCoordinate.y, _missionItemPrevious.altitude.value);

                _geo2EnuCopy.coordinate = _missionItem.coordinate;
                _geo2EnuCopy.coordinate.altitude = 0;
                var p2 = Qt.vector3d(_geo2EnuCopy.localCoordinate.x, _geo2EnuCopy.localCoordinate.y, _missionItem.altitude.value);

                missionPathModel.append({
                                            "x_1": p1.x,
                                            "y_1": p1.y,
                                            "z_1": p1.z,
                                            "x_2": p2.x,
                                            "y_2": p2.y,
                                            "z_2": p2.z,
                                        });
                _missionItemPrevious = _missionItem;
            }
        }
    }

    GeoCoordinateType{
        id:goe2Enu
        gpsRef: _backendQml.gpsRef
    }

    ListModel{
        id: missionWaypointListModel
    }

    ListModel{
        id: missionPathModel
    }

    DroneModelDjiF450{
        id: droneDji3DModel
        vehicle: _vehicle
        modelScale: Qt.vector3d(0.05, 0.05, 0.05)
        altitudeBias: _altitudeBias
        gpsRef: _backendQml.gpsRef
    }

    Repeater3D{
        id:waypints3DRepeater
        model: missionWaypointListModel

        delegate: Waypoint3DModel{
            opacity: 0.8
            missionItem: model
            altitudeBias: _altitudeBias
        }
    }

    Repeater3D{
        id:mission3DPathRepeater
        model: missionPathModel

        delegate: Line3D{
            p_1: Qt.vector3d(model.x_1 * 10, model.y_1 * 10, (model.z_1 + _altitudeBias) * 10)
            p_2: Qt.vector3d(model.x_2 * 10, model.y_2 * 10, (model.z_2 + _altitudeBias) * 10)
            lineWidth:8
            color: "orange"
        }
    }

    Connections {
        target: _missionController
        onVisualItemsChanged: {
            addMissionItemsToListModel()
            addSegmentToMissionPathModel()

        }
    }

    Connections {
        target: _backendQml
        onGpsRefChanged: {
            addMissionItemsToListModel()
            addSegmentToMissionPathModel()

        }
    }
}

#######################################################
#                   Main QGC library
#######################################################
project(qgc)

#######################################################
#             Source Files
#######################################################
add_library(${PROJECT_NAME} STATIC
        CmdLineOptParser.cc
        CmdLineOptParser.h
        QGCApplication.cc
        QGCApplication.h
        QGCConfig.h
        QGCToolbox.cc
        QGCToolbox.h
)

# Subdirectories
add_subdirectory(ADSB)
add_subdirectory(AirLink)
add_subdirectory(AnalyzeView)
add_subdirectory(api)
add_subdirectory(Audio)
add_subdirectory(AutoPilotPlugins)
add_subdirectory(Camera)
add_subdirectory(comm)
add_subdirectory(Compression)
add_subdirectory(FactSystem)
add_subdirectory(FirmwarePlugin)
add_subdirectory(FlightDisplay)
add_subdirectory(FlightMap)
add_subdirectory(FollowMe)
add_subdirectory(Geo)
add_subdirectory(GPS)
add_subdirectory(Joystick)
add_subdirectory(MissionManager)
add_subdirectory(PlanView)
add_subdirectory(PositionManager)
add_subdirectory(QmlControls)
add_subdirectory(QtLocationPlugin)
add_subdirectory(Settings)
add_subdirectory(Terrain)
add_subdirectory(ui)
add_subdirectory(Utilities)
add_subdirectory(UTMSP)
add_subdirectory(Vehicle)
add_subdirectory(VehicleSetup)
add_subdirectory(VideoManager)
add_subdirectory(VideoReceiver)
add_subdirectory(Viewer3D)

#######################################################
#               Linking Libraries
#######################################################
target_link_libraries(${PROJECT_NAME}
        PUBLIC
	    Qt5::QuickControls2
            Qt5::QuickWidgets
            Qt5::Widgets

            ADSB
            AirLink
            AnalyzeView
            api
            Audio
            AutoPilotPlugins
            Camera
            comm
            FactSystem
            FirmwarePlugin
            FlightMap
            FollowMe
            Geo
            gps
            Joystick
            MissionManager
            PositionManager
            QmlControls
            QtLocationPlugin
            Settings
            Terrain
            Utilities
            UTMSP
            Vehicle
            VehicleSetup
            VideoManager
            Viewer3D
)

target_include_directories(${PROJECT_NAME} PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

if(ANDROID)
    target_sources(qgc
        PUBLIC
            ${CMAKE_SOURCE_DIR}/android/src/AndroidInit.cpp
            ${CMAKE_SOURCE_DIR}/android/src/AndroidInterface.cc
            ${CMAKE_SOURCE_DIR}/android/src/AndroidInterface.h
    )

    target_link_libraries(qgc
        PUBLIC
            Qt5::CorePrivate
    )

    target_include_directories(qgc PUBLIC ${CMAKE_SOURCE_DIR}/android/src)
else()
    target_sources(qgc
	    PRIVATE
		RunGuard.cc
		RunGuard.h
    )
endif()

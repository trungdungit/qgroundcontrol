find_package(Qt5 REQUIRED COMPONENTS Core)
find_package(Threads REQUIRED)

option(CONFIG_UTM_ADAPTER "Enable UTM Adapter" OFF) # TODO: Make this QGC_CONFIG_UTM_ADAPTER

if(CONFIG_UTM_ADAPTER)
    message(STATUS "UTMSP is Initialized")
    target_sources(UTMSP
        PRIVATE
            UTMSPAircraft.cpp
            UTMSPAircraft.h
            UTMSPAuthorization.cpp
            UTMSPAuthorization.h
            UTMSPBlenderRestInterface.cpp
            UTMSPBlenderRestInterface.h
            UTMSPFlightPlanManager.cpp
            UTMSPFlightPlanManager.h
            UTMSPManager.cpp
            UTMSPManager.h
            UTMSPNetworkRemoteIDManager.cpp
            UTMSPNetworkRemoteIDManager.h
            UTMSPOperator.cpp
            UTMSPOperator.h
            UTMSPRestInterface.cpp
            UTMSPRestInterface.h
            UTMSPServiceController.cpp
            UTMSPServiceController.h
            UTMSPVehicle.cpp
            UTMSPVehicle.h
    )

    add_custom_target(UTMSPQml
	SOURCES
            UTMSPAdapterEditor.qml
            UTMSPMapVisuals.qml
            UTMSPActivationStatusBar.qml
    )

else()
    # If CONFIG_UTM_ADAPTER is not set, use utmsp_dummy.qrc
    message(STATUS "UTMSP: Dummy is Initialized")

    add_library(UTMSP
            dummy/utmsp_dummy.qrc
    )

    target_include_directories(UTMSP PUBLIC dummy)

endif()

target_link_libraries(UTMSP
	PRIVATE
        	nlohmann_json
	PUBLIC
        	Qt5::Core
        	Qt5::Location
        	Qt5::Widgets
        	Threads::Threads
        	qgc
)

target_include_directories(UTMSP
    PUBLIC
        ${CMAKE_CURRENT_SOURCE_DIR}
        services
)

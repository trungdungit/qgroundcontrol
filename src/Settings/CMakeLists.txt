find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(Settings STATIC
	ADSBVehicleManagerSettings.cc
	ADSBVehicleManagerSettings.h
	APMMavlinkStreamRateSettings.cc
	APMMavlinkStreamRateSettings.h
	AppSettings.cc
	AppSettings.h
	AutoConnectSettings.cc
	AutoConnectSettings.h
	BatteryIndicatorSettings.cc
	BatteryIndicatorSettings.h
	BrandImageSettings.cc
	BrandImageSettings.h
	CustomMavlinkActionsSettings.cc
	CustomMavlinkActionsSettings.h
	FirmwareUpgradeSettings.cc
	FirmwareUpgradeSettings.h
	FlightMapSettings.cc
	FlightMapSettings.h
	FlightModeSettings.cc
	FlightModeSettings.h
	FlyViewSettings.cc
	FlyViewSettings.h
	MapsSettings.cc
    	MapsSettings.h
	OfflineMapsSettings.cc
	OfflineMapsSettings.h
	PlanViewSettings.cc
	PlanViewSettings.h
	RTKSettings.cc
	RTKSettings.h
	SettingsGroup.cc
	SettingsGroup.h
	SettingsManager.cc
	SettingsManager.h
	UnitsSettings.cc
	UnitsSettings.h
	VideoSettings.cc
	VideoSettings.h
	Viewer3DSettings.cc
    	Viewer3DSettings.h
	RemoteIDSettings.h
	RemoteIDSettings.cc
)

target_link_libraries(Settings
	PUBLIC
		qgc
		Qt5::Multimedia
)

target_include_directories(Settings PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

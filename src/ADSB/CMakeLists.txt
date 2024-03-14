find_package(Qt5 REQUIRED COMPONENTS Core Network Positioning)

add_library(ADSB STATIC
	ADSBVehicle.cc
	ADSBVehicle.h
	ADSBVehicleManager.cc
	ADSBVehicleManager.h
)

target_link_libraries(ADSB
	PUBLIC
		Qt5::Core
		Qt5::Network
		Qt5::Positioning
		comm
		qgc
		QmlControls
)

target_include_directories(ADSB PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})



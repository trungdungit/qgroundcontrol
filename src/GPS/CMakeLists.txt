find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(gps STATIC
	definitions.h
	Drivers/src/ashtech.cpp
	Drivers/src/ashtech.h
	Drivers/src/gps_helper.cpp
	Drivers/src/gps_helper.h
	Drivers/src/mtk.cpp
	Drivers/src/mtk.h
	Drivers/src/rtcm.cpp
	Drivers/src/rtcm.h
	Drivers/src/sbf.cpp
	Drivers/src/sbf.h
	Drivers/src/ubx.cpp
	Drivers/src/ubx.h
	GPSManager.cc
	GPSManager.h
	GPSPositionMessage.h
	GPSProvider.cc
	GPSProvider.h
	RTCMMavlink.cc
	RTCMMavlink.h
	satellite_info.h
	sensor_gnss_relative.h
	sensor_gps.h
)

target_link_libraries(gps
	PUBLIC
		Qt5::Core
		comm
		qgc
)

target_include_directories(gps
	PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
		Drivers/src
)

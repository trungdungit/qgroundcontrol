find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(Camera STATIC
	MavlinkCameraControl.cc
	MavlinkCameraControl.h
	QGCCameraIO.cc
	QGCCameraIO.h
	QGCCameraManager.cc
	QGCCameraManager.h
	SimulatedCameraControl.cc
	SimulatedCameraControl.h
	VehicleCameraControl.cc
	VehicleCameraControl.h
)

target_link_libraries(Camera
	PRIVATE
		Compression
	PUBLIC
		qgc
)

target_include_directories(Camera PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


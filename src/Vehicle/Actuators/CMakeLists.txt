find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(Actuators STATIC
	ActuatorActions.cc
	ActuatorActions.h
	ActuatorOutputs.cc
	ActuatorOutputs.h
	Actuators.cc
	Actuators.h
	ActuatorTesting.cc
	ActuatorTesting.h
	Common.cc
	Common.h
	GeometryImage.cc
	GeometryImage.h
	Mixer.cc
	Mixer.h
	MotorAssignment.cc
	MotorAssignment.h
)

target_link_libraries(Actuators
	PRIVATE
		qgc
)

target_include_directories(Actuators PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


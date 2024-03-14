find_package(Qt5 REQUIRED COMPONENTS Core Positioning)

add_library(PositionManager STATIC
	PositionManager.cpp
	PositionManager.h
	SimulatedPosition.cc
	SimulatedPosition.h
)

target_link_libraries(PositionManager
	PUBLIC
		Qt5::Core
		Qt5::Positioning
		qgc
)

target_include_directories(PositionManager PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


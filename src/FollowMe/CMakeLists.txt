find_package(Qt5 REQUIRED COMPONENTS Core Positioning)

add_library(FollowMe STATIC
	FollowMe.cc
	FollowMe.h
)

target_link_libraries(FollowMe
	PUBLIC
		Qt5::Core
		Qt5::Positioning
		comm
		qgc
)

target_include_directories(FollowMe PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

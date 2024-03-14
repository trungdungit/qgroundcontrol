find_package(Qt5 REQUIRED COMPONENTS Core Positioning)

add_library(Geo STATIC
	Constants.hpp
	Math.cpp
	Math.hpp
	MGRS.cpp
	MGRS.hpp
	PolarStereographic.cpp
	PolarStereographic.hpp
	QGCGeo.cc
	QGCGeo.h
	TransverseMercator.cpp
	TransverseMercator.hpp
	Utility.cpp
	Utility.h
	Utility.hpp
	UTMUPS.cpp
	UTMUPS.hpp
)

target_link_libraries(Geo
	PRIVATE
		Qt5::Core
	PUBLIC
		Qt5::Positioning
)

target_include_directories(Geo
	PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
)

find_package(Qt5 REQUIRED COMPONENTS Core Location Network Positioning)

add_library(Terrain STATIC
	TerrainQuery.cc
	TerrainQuery.h
    	TerrainTile.cc
    	TerrainTile.h
)

target_link_libraries(Terrain
	PRIVATE
		Qt5::LocationPrivate
		qgc
		Qt5::Core
		Qt5::Network
		Qt5::Positioning
		Utilities
)

target_include_directories(Terrain PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


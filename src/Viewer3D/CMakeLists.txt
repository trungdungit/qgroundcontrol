find_package(Qt5 REQUIRED COMPONENTS Core Quick3D)

add_library(Viewer3D STATIC
    Viewer3DManager.cc
    CityMapGeometry.cc
    CityMapGeometry.h
    earcut.hpp
    OsmParser.cc
    OsmParser.h
    Viewer3DManager.h
    Viewer3DQmlBackend.cc
    Viewer3DQmlBackend.h
    Viewer3DQmlVariableTypes.h
    Viewer3DUtils.cc
    Viewer3DUtils.h
)

target_link_libraries(Viewer3D
	PUBLIC
		qgc
        	Qt5::Quick3D
)

target_include_directories(Viewer3D PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

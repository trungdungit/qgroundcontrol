find_package(Qt5 REQUIRED COMPONENTS Core Network Positioning Qml)

add_library(Utilities STATIC
    JsonHelper.cc
    JsonHelper.h
    QGC.cc
    QGC.h
    QGCCachedFileDownload.cc
    QGCCachedFileDownload.h
    QGCFileDownload.cc
    QGCFileDownload.h
    QGCLoggingCategory.cc
    QGCLoggingCategory.h
    QGCQGeoCoordinate.cc
    QGCQGeoCoordinate.h
    QGCTemporaryFile.cc
    QGCTemporaryFile.h
    ShapeFileHelper.cc
    ShapeFileHelper.h
    SHPFileHelper.cc
    SHPFileHelper.h
)

if(MOBILE)
	target_sources(Utilities
		PRIVATE
			MobileScreenMgr.cc
        		MobileScreenMgr.h
	)
endif()

set(BUILD_SHAPELIB_CONTRIB OFF CACHE INTERNAL "")
set(BUILD_SHARED_LIBS OFF CACHE INTERNAL "")
set(BUILD_TESTING OFF CACHE INTERNAL "")

include(FetchContent)
FetchContent_Declare(shapelib
	GIT_REPOSITORY https://github.com/OSGeo/shapelib.git
	GIT_TAG v1.6.0
    	GIT_SHALLOW TRUE
)
FetchContent_GetProperties(shapelib)
if(NOT shapelib_POPULATED)
	FetchContent_Populate(shapelib)
	add_subdirectory(${shapelib_SOURCE_DIR} ${shapelib_BINARY_DIR} EXCLUDE_FROM_ALL)
endif()

target_link_libraries(Utilities
	PRIVATE
		Qt5::Qml
		shp
		qgc
	PUBLIC
		Qt5::Core
		Qt5::Positioning
		Qt5::Network
)

target_include_directories(Utilities
	PUBLIC
		${CMAKE_CURRENT_SOURCE_DIR}
        ${CMAKE_SOURCE_DIR}/libs/shapelib
)

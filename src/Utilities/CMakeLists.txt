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

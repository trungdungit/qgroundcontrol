find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(api STATIC
	QGCCorePlugin.cc
	QGCCorePlugin.h
	QGCOptions.cc
	QGCOptions.h
	QGCSettings.cc
	QGCSettings.h
	QmlComponentInfo.cc
	QmlComponentInfo.h
)
target_link_libraries(api
	PUBLIC
		qgc
)

target_include_directories(api PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(AnalyzeView STATIC
	ExifParser.cc
	ExifParser.h
	GeoTagController.cc
	GeoTagController.h
	LogDownloadController.cc
	LogDownloadController.h
	MavlinkConsoleController.cc
	MavlinkConsoleController.h
	MAVLinkInspectorController.cc
	MAVLinkInspectorController.h
	PX4LogParser.cc
	PX4LogParser.h
	ULogParser.cc
	ULogParser.h
)

add_custom_target(AnalyzeViewQml
	SOURCES
		AnalyzePage.qml
		AnalyzeView.qml
		GeoTagPage.qml
		LogDownloadPage.qml
		MavlinkConsolePage.qml
		MAVLinkInspectorPage.qml
		VibrationPage.qml
)

target_link_libraries(AnalyzeView
	PRIVATE
		qgc

	PUBLIC
		Qt5::Charts
		Qt5::Location
		Qt5::TextToSpeech
		Qt5::Widgets
)

target_include_directories(AnalyzeView INTERFACE ${CMAKE_CURRENT_SOURCE_DIR})


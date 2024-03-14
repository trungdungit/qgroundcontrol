find_package(Qt5 REQUIRED COMPONENTS Core TextToSpeech Widgets)

add_library(Audio STATIC
	AudioOutput.cc
	AudioOutput.h
)

target_link_libraries(Audio
	PRIVATE
		Qt5::Widgets
		qgc
	PUBLIC
		Qt5::Core
		Qt5::TextToSpeech
)

target_include_directories(Audio PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})


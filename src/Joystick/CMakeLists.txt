find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(Joystick STATIC
	Joystick.cc
	Joystick.h
	JoystickManager.cc
	JoystickManager.h
)

if(ANDROID)
	target_sources(Joystick
		PRIVATE
			JoystickAndroid.cc
			JoystickAndroid.h
	)

	target_link_libraries(Joystick
		PUBLIC
			Qt5::CorePrivate
	)
else()
	include(BuildSdl2)
	if(SDL2_FOUND)
		target_sources(Joystick
			PRIVATE
				JoystickSDL.cc
				JoystickSDL.h
		)
    	target_link_libraries(Joystick
    		PUBLIC
    			SDL2::SDL2
    	)
	endif()
endif()

target_link_libraries(Joystick
	PUBLIC
		Qt5::Core
		qgc
		Vehicle
)

target_include_directories(Joystick PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

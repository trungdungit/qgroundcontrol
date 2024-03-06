if(ANDROID)
	find_package(Qt5 REQUIRED COMPONENTS Core)

	add_library(qtandroidserialport STATIC
		src/qserialport.cpp
		src/qserialport.h
		src/qserialport_p.h
		src/qserialport_android.cpp
		src/qserialport_android_p.h
		src/qserialportinfo.cpp
		src/qserialportinfo.h
		src/qserialportinfo_p.h
		src/qserialportinfo_android.cpp
	)

	target_link_libraries(qtandroidserialport
		PRIVATE
			qgc
		PUBLIC
			Qt5::CorePrivate
	)

	target_include_directories(qtandroidserialport PUBLIC ${CMAKE_CURRENT_SOURCE_DIR}/src)
endif()

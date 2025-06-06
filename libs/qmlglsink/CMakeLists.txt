option(QGC_ENABLE_VIDEOSTREAMING "Enable video streaming" ON)
if(QGC_ENABLE_VIDEOSTREAMING)
    message(STATUS "Enabling video streaming support")

	find_package(PkgConfig)

	set(GST_DEPENDENCIES
	    gstreamer-1.0>=1.16
	    gstreamer-video-1.0>=1.16
	    gstreamer-gl-1.0>=1.16
	)

	if(LINUX OR ANDROID)
	    list(APPEND GST_DEPENDENCIES egl)
	endif()

    if(NOT ANDROID)
        pkg_check_modules(GST
            ${GST_DEPENDENCIES}
        )
    endif()

	message(STATUS "GStreamer libs: ${GST_LIBRARIES}")
	message(STATUS "GStreamer include dirs: ${GST_INCLUDE_DIRS}")
	message(STATUS "GStreamer link dirs: ${GST_LIBRARY_DIRS}")
	message(STATUS "GStreamer cflags: ${GST_CFLAGS}")
	message(STATUS "GStreamer ldflags: ${GST_LDFLAGS}")
	message(STATUS "GStreamer libs: ${GST_LIBS}")

	if(LINUX OR ANDROID)
	    message(STATUS "GStreamer egl libs: ${GST_EGL_LIBRARIES}")
	    message(STATUS "GStreamer egl include dirs: ${GST_EGL_INCLUDE_DIRS}")
	    message(STATUS "GStreamer egl link dirs: ${GST_EGL_LIBRARY_DIRS}")
	    message(STATUS "GStreamer egl cflags: ${GST_EGL_CFLAGS}")
	    message(STATUS "GStreamer egl ldflags: ${GST_EGL_LDFLAGS}")
	    message(STATUS "GStreamer egl libs: ${GST_EGL_LIBS}")
	endif()

	message(STATUS "gst found ${GST_FOUND}")

	if(GST_FOUND)
	    message(STATUS "Building qmlglsink")

		find_package(Qt5 REQUIRED COMPONENTS Gui OpenGL)
		find_package(OpenGL)

		add_library(qmlglsink
			qt/gstplugin.cc
	    		qt/gstqtglutility.cc
	    		qt/gstqsgtexture.cc
	    		qt/gstqtsink.cc
			qt/gstqtsrc.cc
	    		qt/qtwindow.cc
	    		qt/qtitem.cc
		)

	    target_compile_definitions(qmlglsink PUBLIC QGC_GST_STREAMING)

		if(LINUX)
			option(USE_WAYLAND "Use Wayland instead of X11 for building GST" ON)
			if(USE_WAYLAND)
				message(STATUS "Using wayland for qmlglsink")
				target_compile_definitions(qmlglsink PUBLIC HAVE_QT_WAYLAND)
			else()
				message(STATUS "Using x11 for qmlglsink")
				target_compile_definitions(qmlglsink PUBLIC HAVE_QT_X11)
			endif()
			target_compile_definitions(qmlglsink PUBLIC HAVE_QT_EGLFS HAVE_QT_QPA_HEADER)
		elseif(MACOS)
			target_compile_definitions(qmlglsink PUBLIC HAVE_QT_MAC)
		elseif(IOS)
			target_compile_definitions(qmlglsink PUBLIC HAVE_QT_IOS)
		elseif(WIN32)
			target_compile_definitions(qmlglsink PUBLIC HAVE_QT_WIN32 HAVE_QT_QPA_HEADER)

			target_link_libraries(qmlglsink
				PUBLIC
					OpenGL::GL
					user32.lib
			)
		elseif(ANDROID)
			target_compile_definitions(qmlglsink PUBLIC HAVE_QT_ANDROID)
		endif()

		target_link_libraries(qmlglsink
			PUBLIC
				Qt5::Core
				Qt5::OpenGL
				Qt5::GuiPrivate
				${GST_LINK_LIBRARIES}
		)

		target_include_directories(qmlglsink PUBLIC ${GST_INCLUDE_DIRS})
		if (MSVC)
			target_include_directories(qmlglsink PRIVATE ${CMAKE_CURRENT_SOURCE_DIR}/windows)
		else()
			target_compile_options(qmlglsink
				PRIVATE
					-Wno-unused-parameter
					-Wno-implicit-fallthrough
				)
		endif()
	endif()
else()
    message(STATUS "Video streaming disabled")
endif()

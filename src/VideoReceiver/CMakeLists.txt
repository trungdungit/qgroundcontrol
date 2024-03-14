find_package(Qt5 REQUIRED COMPONENTS Core Multimedia)

add_library(VideoReceiver STATIC
    VideoReceiver.h
)

target_link_libraries(VideoReceiver
    PUBLIC
        Qt5::Multimedia
        Qt5::OpenGL
        Qt5::Quick
        Utilities
)

target_include_directories(VideoReceiver PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

if(GST_FOUND)
    target_sources(VideoReceiver
        PRIVATE
            gstqgc.c
            gstqgcvideosinkbin.c
            GStreamer.cc
            GStreamer.h
            GstVideoReceiver.cc
            GstVideoReceiver.h
    )

    target_link_libraries(VideoReceiver
        PUBLIC
            qmlglsink
            Settings
    )
endif()

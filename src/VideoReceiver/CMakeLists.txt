find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(VideoReceiver STATIC
    VideoReceiver.h
)

target_link_libraries(VideoReceiver
    PUBLIC
        Qt5::Core
)

target_include_directories(VideoReceiver PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})

add_subdirectory(${CMAKE_SOURCE_DIR}/libs/qmlglsink qmlglsink.build)

if(GST_FOUND)
    find_package(Qt5 REQUIRED COMPONENTS Quick)
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
        PRIVATE
            qmlglsink
            Utilities
        PUBLIC
            Qt5::Quick
            Settings
    )
    
    target_compile_definitions(VideoReceiver PUBLIC QGC_GST_STREAMING)
    
    if(CMAKE_BUILD_TYPE STREQUAL "Release")
        target_compile_definitions(VideoReceiver PRIVATE QGC_INSTALL_RELEASE)
    endif()
    
endif()

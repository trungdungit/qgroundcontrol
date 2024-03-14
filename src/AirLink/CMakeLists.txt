find_package(Qt5 REQUIRED COMPONENTS Core)

add_library(AirLink STATIC)

option(QGC_AIRLINK_DISABLED "Enable airlink" OFF)
if(NOT ${QGC_AIRLINK_DISABLED})
    find_package(Qt5 REQUIRED COMPONENTS Network)

    target_sources(AirLink
        PRIVATE
            AirlinkLink.cc
            AirlinkLink.h
            AirLinkManager.cc
            AirLinkManager.h
    )

    add_custom_target(AirLinkQml
        SOURCES
            AirLinkSettings.qml
    )

    target_link_libraries(AirLink
        PUBLIC
            Qt5::Core
            Qt5::Network
            FactSystem
            Settings
            qgc
    )

    target_include_directories(AirLink PUBLIC ${CMAKE_CURRENT_SOURCE_DIR})
else()
    target_compile_definitions(AirLink PUBLIC QGC_AIRLINK_DISABLED)
endif()

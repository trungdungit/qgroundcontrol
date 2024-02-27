find_package(Qt5 COMPONENTS Core Network REQUIRED)

add_library(AirLink STATIC
    AirlinkLink.cc
    AirlinkLink.h
    AirLinkManager.cc
    AirLinkManager.h
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

find_package(Qt5 REQUIRED COMPONENTS Core Qml)

add_custom_target(CommonAutoPilotPluginQml
SOURCES
    ESP8266Component.qml
    ESP8266ComponentSummary.qml
    MotorComponent.qml
    RadioComponent.qml
    SetupPage.qml
    SyslinkComponent.qml
)

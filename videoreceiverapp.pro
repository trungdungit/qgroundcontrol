QMAKE_PROJECT_DEPTH = 0 # undocumented qmake flag to force absolute paths in makefiles

exists($${OUT_PWD}/videoreceiverapp.pro) {
    error("You must use shadow build (e.g. mkdir build; cd build; qmake ../videoreceiverapp.pro).")
}

message(Qt version $$[QT_VERSION])

!contains(CONFIG, DISABLE_QT_VERSION_CHECK) {
    !versionAtLeast(QT_VERSION, 5.14.1) {
        error("Qt version 5.14.1 or newer required. Found $$QT_VERSION")
    }
}


include(QGCCommon.pri)

TARGET   = VideoReceiverApp
TEMPLATE = app
QGCROOT  = $$PWD

QT += \
    concurrent \
    gui \
    opengl \
    qml \
    quick \
    quickcontrols2 \
    quickwidgets \
    widgets \
    xml \
    core-private

# Multimedia only used if QVC is enabled
!contains (DEFINES, QGC_DISABLE_UVC) {
    QT += \
        multimedia
}

INCLUDEPATH += .

INCLUDEPATH += \
    include/ui \
    src \
    VideoReceiverApp


#-------------------------------------------------------------------------------------
# Video Streaming


QT += \
    opengl \
    gui-private

include(src/VideoReceiver/VideoReceiver.pri)

HEADERS += \
    src/QGCLoggingCategory.h


SOURCES += \
    VideoReceiverApp/main.cpp \
    src/QGCLoggingCategory.cc \

RESOURCES += \
    VideoReceiverApp/qml.qrc

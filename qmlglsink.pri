LinuxBuild {
    UseWayland: {
        DEFINES += HAVE_QT_WAYLAND
    } else {
        DEFINES += HAVE_QT_X11
    }
    DEFINES += HAVE_QT_EGLFS HAVE_QT_QPA_HEADER
} else:MacBuild {
    DEFINES += HAVE_QT_MAC
} else:iOSBuild {
    DEFINES += HAVE_QT_IOS
} else:WindowsBuild {
    DEFINES += HAVE_QT_WIN32 HAVE_QT_QPA_HEADER
    LIBS += opengl32.lib user32.lib
} else:AndroidBuild {
    DEFINES += HAVE_QT_ANDROID
}

SOURCES += \
    libs/qmlglsink/qt/gstplugin.cc \
    libs/qmlglsink/qt/gstqtglutility.cc \
    libs/qmlglsink/qt/gstqsgtexture.cc \
    libs/qmlglsink/qt/gstqtsink.cc \
    libs/qmlglsink/qt/gstqtsrc.cc \
    libs/qmlglsink/qt/qtwindow.cc \
    libs/qmlglsink/qt/qtitem.cc

HEADERS += \
    libs/qmlglsink/qt/gstqsgtexture.h \
    libs/qmlglsink/qt/gstqtgl.h \
    libs/qmlglsink/qt/gstqtglutility.h \
    libs/qmlglsink/qt/gstqtsink.h \
    libs/qmlglsink/qt/gstqtsrc.h \
    libs/qmlglsink/qt/qtwindow.h \
    libs/qmlglsink/qt/qtitem.h

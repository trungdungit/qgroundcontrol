#pragma once

#include <QObject>
#include <QLoggingCategory>
#include <QQuickItem>

#include "VideoSettings.h"

Q_DECLARE_LOGGING_CATEGORY(GStreamerLog)
Q_DECLARE_LOGGING_CATEGORY(GStreamerAPILog)

class VideoReceiver;

class GStreamer {
public:
    static void blacklist(VideoDecoderOptions option);
    static void initialize(int argc, char* argv[], int debuglevel);
    static void* createVideoSink(QObject* parent, QQuickItem* widget);
    static void releaseVideoSink(void* sink);
    static VideoReceiver* createVideoReceiver(QObject* parent);
};

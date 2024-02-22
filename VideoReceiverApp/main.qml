import QtQuick 2.4
import QtQuick.Layouts 1.2
import QtQuick.Window 2.4
import org.freedesktop.gstreamer.GLVideoItem

Window {
    visible: true
    width: 640
    height: 480
    title: qsTr("VideoReceiverApp")

    RowLayout {
        anchors.fill: parent
        spacing: 0

        GstGLVideoItem {
            id: video
            objectName: "videoItem"
            Layout.fillWidth: true
            Layout.fillHeight: true
        }
    }
}

import QtQuick          2.6
import QtQuick.Controls 1.4

MenuItem {
    // MenuItem doesn't support !visible so we have to hack it in
    height: visible ? implicitHeight : 0
}

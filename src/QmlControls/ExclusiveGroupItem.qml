import QtQuick           2.12
import QtQuick.Controls  2.12


/// The ExclusiveGroupItem control can be used as a base class for a control which
/// needs support for ButtonGroup
Item {
    id: _root

    property bool checked: false
    property ButtonGroup buttonGroup: null

    onButtonGroupChanged: {
        if (buttonGroup) {
            buttonGroup.bindCheckable(_root)
        }
    }
}

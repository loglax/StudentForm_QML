import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

ComboBox {
    id: control
    height: 40
    Layout.preferredHeight: 40

    background: Rectangle {
        color: "white"
        border.color: control.activeFocus ? "blue" : "black"
        border.width: 1
        radius: 4
        MouseArea {
            anchors.fill: parent
            hoverEnabled: true
            acceptedButtons: Qt.NoButton
            cursorShape: Qt.PointingHandCursor
        }
    }

    contentItem: Text {
        text: control.displayText
        font: control.font
        color: "black"
        verticalAlignment: Text.AlignVCenter
        leftPadding: 6
        elide: Text.ElideRight
    }

    indicator: Text {
        text: "▼"
        color: "black"
        font.pixelSize: 12
        anchors.verticalCenter: parent.verticalCenter
        anchors.right: parent.right
        anchors.rightMargin: 8
    }
}

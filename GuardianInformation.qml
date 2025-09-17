import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12

Rectangle {
    id: guardianInfoRect
    width: 950
    height: 250
    color: "skyblue"
    radius: 10
    border.color: "black"
    border.width: 2
    
    // Properties to make form data accessible from outside
    property alias guardianName: guardianName.text
    property alias guardianContactNo: guardianContactNo.text
    property alias guardianAddress: guardianAddress.text
    
    // Function to clear all guardian fields
    function clearAllFields() {
        guardianName.text = ""
        guardianContactNo.text = ""
        guardianAddress.text = ""
    }
    
    // Function to load guardian data from file
    function loadGuardianData(guardianNameVal, guardianContactNoVal, guardianAddressVal) {
        guardianName.text = guardianNameVal || ""
        guardianContactNo.text = guardianContactNoVal > 0 ? String(guardianContactNoVal) : ""
        guardianAddress.text = guardianAddressVal || ""
    }
    
    Column {
        anchors.fill: parent
        anchors.margins: 20
        spacing: 20
        
        Text {
            text: "Guardian Information"
            font.family: "Sans-Serif"
            font.bold: true
            font.pixelSize: 36
            color: "black"
            anchors.horizontalCenter: parent.horizontalCenter
        }
        
        GridLayout {
            columns: 4
            columnSpacing: 20
            rowSpacing: 20
            anchors.horizontalCenter: parent.horizontalCenter
            
            Text {
                text: "Guardian Name:"
                font.pixelSize: 18
            }
            TextField {
                id: guardianName
                placeholderText: "Enter Guardian Name"
                Layout.preferredHeight: 40
                Layout.preferredWidth: 300
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }
            Text {
                text: "Contact No:"
                font.pixelSize: 18
            }
            TextField {
                id: guardianContactNo
                placeholderText: "Enter Guardian Contact"
                validator: RegExpValidator { regExp: /^[0-9]*$/ }
                Layout.preferredHeight: 40
                Layout.preferredWidth: 300
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }
            
            Text {
                text: "Address:"
                font.pixelSize: 18
            }
            TextField {
                id: guardianAddress
                placeholderText: "Enter Guardian Address"
                Layout.columnSpan: 3
                Layout.preferredHeight: 40
                Layout.preferredWidth: 750
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }
        }
    }
}


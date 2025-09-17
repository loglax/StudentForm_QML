import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import "."

Rectangle {
    id: personalProfileRect
    width: 950
    height: 800
    color: "skyblue"
    border.color: "black"
    border.width: 2
    radius: 10

    // Properties to make form data accessible from outside
    property alias scholarNo: scholarNo.text
    property alias admissionNo: admissionNo.text
    property alias studentName: studentName.text
    property alias rollNo: rollNo.text
    property alias dateOfAdmission: dateOfAdmission.text
    property alias fathersName: fathersName.text
    property alias mothersName: mothersName.text
    property alias address: address.text
    property alias documents: documents.text
    property alias contactNo: contactNo.text
    property alias emailId: emailId.text
    property string photoPath: ""

    // Properties for ComboBox values
    property string gender: genderCombo.currentText
    property string religion: religionCombo.currentText
    property string nationality: nationalityCombo.currentText
    property string course: courseCombo.currentText
    property string branch: branchCombo.currentText
    property string semester: semesterCombo.currentText
    property string section: sectionCombo.currentText

    // Function to clear all personal profile fields
    function clearAllFields() {
        // Clear text fields
        scholarNo.text = ""
        admissionNo.text = ""
        studentName.text = ""
        rollNo.text = ""
        dateOfAdmission.text = ""
        fathersName.text = ""
        mothersName.text = ""
        address.text = ""
        documents.text = ""
        contactNo.text = ""
        emailId.text = ""
        photoPath = ""

        // Reset combo boxes
        genderCombo.currentIndex = 0
        religionCombo.currentIndex = 0
        nationalityCombo.currentIndex = 0
        courseCombo.currentIndex = 0
        branchCombo.currentIndex = 0
        semesterCombo.currentIndex = 0
        sectionCombo.currentIndex = 0
    }

    // Function to load personal data from file
    function loadPersonalData(scholarNoVal, admissionNoVal, studentNameVal, rollNoVal, dateOfAdmissionVal,
                              genderVal, religionVal, nationalityVal, fathersNameVal, mothersNameVal, addressVal,
                              courseVal, branchVal, semesterVal, sectionVal, documentsVal, contactNoVal, emailIdVal, photoPathVal) {
        // Load text fields
        scholarNo.text = scholarNoVal || ""
        admissionNo.text = admissionNoVal || ""
        studentName.text = studentNameVal || ""
        rollNo.text = rollNoVal || ""
        dateOfAdmission.text = dateOfAdmissionVal || ""
        fathersName.text = fathersNameVal || ""
        mothersName.text = mothersNameVal || ""
        address.text = addressVal || ""
        documents.text = documentsVal || ""
        contactNo.text = contactNoVal > 0 ? String(contactNoVal) : ""
        emailId.text = emailIdVal || ""
        photoPath = photoPathVal || ""

        // Set combo box values
        setComboValue(genderCombo, genderVal)
        setComboValue(religionCombo, religionVal)
        setComboValue(nationalityCombo, nationalityVal)
        setComboValue(courseCombo, courseVal)
        setComboValue(branchCombo, branchVal)
        setComboValue(semesterCombo, semesterVal)
        setComboValue(sectionCombo, sectionVal)
    }

    // Helper function to set combo box value
    function setComboValue(combo, value) {
        if (value) {
            var index = combo.find(value)
            if (index >= 0) {
                combo.currentIndex = index
            }
        }
    }

    Column {
        spacing: 20
        anchors.fill: parent
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.margins: 20

        Text {
            text: "Personal Profile"
            font.family: "Sans-Serif"
            font.bold: true
            font.pixelSize: 36
            color: "black"
            horizontalAlignment: Text.AlignHCenter
            anchors.horizontalCenter: parent.horizontalCenter
        }

        GridLayout {
            columns: 4
            rowSpacing: 10
            columnSpacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Text { text: "Scholar No:" }
            TextField {
                id: scholarNo
                placeholderText: "Enter Scholar No"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Admission No:" }
            TextField {
                id: admissionNo
                placeholderText: "Enter Admission No"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Student Name:" }
            TextField {
                id: studentName
                placeholderText: "Enter Student Name"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Roll No:" }
            TextField {
                id: rollNo
                placeholderText: "Enter Roll No"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Date of Admission:" }
            TextField {
                id: dateOfAdmission
                placeholderText: "YYYY-MM-DD"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Gender:" }
            CustomComboBox {
                id: genderCombo
                model: ["Male", "Female", "Other"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Religion:" }
            CustomComboBox {
                id: religionCombo
                model: ["Hindu", "Muslim", "Christian", "Other"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Nationality:" }
            CustomComboBox {
                id: nationalityCombo
                model: ["Indian", "Other"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Father's Name:" }
            TextField {
                id: fathersName
                placeholderText: "Enter Father's Name"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Mother's Name:" }
            TextField {
                id: mothersName
                placeholderText: "Enter Mother's Name"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Enter Address:" }
            TextField {
                id: address
                Layout.columnSpan: 3
                Layout.fillWidth: true
                placeholderText: "Enter Complete Address"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Course:" }
            CustomComboBox {
                id: courseCombo
                model: ["BSc", "BCom", "BCA","BTech", "MSc", "MCom", "MCA","MTech"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Branch:" }
            CustomComboBox {
                id: branchCombo
                model: ["CS", "IT", "EC"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Semester:" }
            CustomComboBox {
                id: semesterCombo
                model: ["1st", "2nd", "3rd", "4th", "5th", "6th"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Section:" }
            CustomComboBox {
                id: sectionCombo
                model: ["A", "B", "C", "D"]
                currentIndex: 0
                Layout.fillWidth: true
            }

            Text { text: "Documents:" }
            TextField {
                id: documents
                placeholderText: "Enter Documents"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Contact No:" }
            TextField {
                id: contactNo
                placeholderText: "Enter Contact Number"
                validator: RegExpValidator { regExp: /^[0-9]*$/ }
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }

            Text { text: "Email Id:" }
            TextField {
                id: emailId
                placeholderText: "Enter Email ID"
                Layout.preferredWidth: 200
                Layout.preferredHeight: 40
                horizontalAlignment: Text.AlignLeft
                background: Rectangle {
                    color: "white"
                    border.color: parent.activeFocus ? "blue" : "black"
                    border.width: 1
                    radius: 4
                }
            }
        }

        Column {
            spacing: 10
            anchors.horizontalCenter: parent.horizontalCenter

            Rectangle {
                id: photoRect
                width: 195
                height: 110
                color: "gray"

                Image {
                    id: photoImage
                    anchors.fill: parent
                    source: photoPath
                    fillMode: Image.Stretch
                    visible: photoPath !== ""
                }
                Text {
                    anchors.centerIn: parent
                    text: "Photo"
                    color: "white"
                    visible: photoPath === ""
                }
            }

            Rectangle {
                width: 120
                height: 40
                color: browseMouseArea.pressed ? "#3cb371" : browseMouseArea.hovered ? "#ffd700" : "#00fa9a"
                radius: 25
                border.color: "#3cb371"
                border.width: 1
                anchors.horizontalCenter: photoRect.horizontalCenter

                MouseArea {
                    id: browseMouseArea
                    anchors.fill: parent
                    cursorShape: Qt.PointingHandCursor
                    hoverEnabled: true
                    onClicked: fileDialog.open()
                }
                Text {
                    anchors.centerIn: parent
                    text: "Browse"
                    color: "black"
                }
            }
        }
    }

    // FileDialog to select a photo
    FileDialog {
        id: fileDialog
        title: "Select a Photo"
        folder: shortcuts.pictures
        nameFilters: ["Image files (*.png *.jpg *.jpeg)"]
        onAccepted: {
            photoPath = fileDialog.fileUrl.toString()
        }
    }
}

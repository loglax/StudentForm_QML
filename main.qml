import QtQuick 2.12
import QtQuick.Window 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import QtQuick.Dialogs 1.2
import StudentApp 1.0

ApplicationWindow {
    id: mainWindow
    width: 1000
    height: 800
    visible: true
    title: "Student Information Management System"

    // Create our student model
    StudentModel {
        id: studentModel

        // Handle signals from the model
        onFieldDataLoaded: {
            loadDataIntoFields(scholarNo, admissionNo, studentName, rollNo, dateOfAdmission,
                               gender, religion, nationality, fathersName, mothersName, address,
                               course, branch, semester, section, documents, contactNo, emailId, photoPath,
                               guardianName, guardianContactNo, guardianAddress,
                               courseNames, passingYears, percentages, boardUniversities)
        }

        onOperationResult: {
            statusText.text = message
            console.log("Operation result:", message)
        }
    }

    ScrollView {
        anchors.fill: parent

        Column {
            spacing: 20
            width: parent.width
            anchors.horizontalCenter: parent.horizontalCenter

            // Include our form components
            PersonalProfile {
                id: personalProfile
                anchors.horizontalCenter: parent.horizontalCenter
            }

            GuardianInformation {
                id: guardianInfo
                anchors.horizontalCenter: parent.horizontalCenter
            }

            AcademicDetails {
                id: academicDetails
                anchors.horizontalCenter: parent.horizontalCenter
            }

            // Button row
            Row {
                spacing: 30
                anchors.horizontalCenter: parent.horizontalCenter

                // New Button - Clear all fields
                Button {
                    text: "New"
                    width: 120
                    height: 40
                    background: Rectangle {
                        color: parent.pressed ? "blue" : parent.hovered ? "royalblue" : "navy"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        id: newMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            clearAllFields()
                            studentModel.clearAllFields()
                        }
                    }
                }

                // Save Button - Save to text file
                Button {
                    text: "Open"
                    width: 120
                    height: 40
                    background: Rectangle {
                        color: parent.pressed ? "blue" : parent.hovered ? "royalblue" : "navy"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        id: saveMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            loadFileDialog.open()
                        }
                    }
                }

                // Update Button - Load from text file
                Button {
                    text: "Save"
                    width: 120
                    height: 40
                    background: Rectangle {
                        color: parent.pressed ? "blue" : parent.hovered ? "royalblue" : "navy"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        id: updateMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            saveStudentData()

                        }
                    }
                }

                // Delete Button - Delete text file
                Button {
                    text: "Delete"
                    width: 120
                    height: 40
                    background: Rectangle {
                        color: parent.pressed ? "blue" : parent.hovered ? "royalblue" : "navy"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        id: deleteMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            deleteFileDialog.open()
                        }
                    }
                }

                // Print Button - Print current data
                Button {
                    text: "Print"
                    width: 120
                    height: 40
                    background: Rectangle {
                        color: parent.pressed ? "blue" : parent.hovered ? "royalblue" : "navy"
                        radius: 10
                        border.color: "black"
                        border.width: 1
                    }
                    contentItem: Text {
                        text: parent.text
                        font.bold: true
                        color: "white"
                        horizontalAlignment: Text.AlignHCenter
                        verticalAlignment: Text.AlignVCenter
                    }
                    MouseArea {
                        id: printMouseArea
                        anchors.fill: parent
                        hoverEnabled: true
                        cursorShape: Qt.PointingHandCursor
                        onClicked: {
                            printCurrentData()
                        }
                    }
                }
            }

            // Status message area
            Rectangle {
                width: parent.width
                height: 60
                anchors.horizontalCenter: parent.horizontalCenter
                color: "lightgray"
                border.color: "black"
                border.width: 1
                radius: 5

                Text {
                    id: statusText
                    anchors.centerIn: parent
                    text: "Ready to manage student records"
                    color: "black"
                    wrapMode: Text.WordWrap
                    width: parent.width - 20
                    horizontalAlignment: Text.AlignHCenter
                }
            }
        }
    }

    // Simplified File dialogs for Update and Delete operations
    FileDialog {
        id: loadFileDialog
        title: "Select Student Record File to Load"
        folder: shortcuts.documents
        nameFilters: ["Text files (*.txt)"]
        selectExisting: true
        selectMultiple: false
        onAccepted: {
            console.log("Load file selected:", loadFileDialog.fileUrl)
            statusText.text = "Loading student record..."
            studentModel.loadFromTextFile(loadFileDialog.fileUrl.toString())
        }
        onRejected: {
            statusText.text = "Load operation cancelled"
        }
    }

    FileDialog {
        id: deleteFileDialog
        title: "Select Student Record File to Delete"
        folder: shortcuts.documents
        nameFilters: ["Text files (*.txt)"]
        selectExisting: true
        selectMultiple: false
        onAccepted: {
            console.log("Delete file selected:", deleteFileDialog.fileUrl)
            statusText.text = "Deleting student record..."
            studentModel.deleteTextFile(deleteFileDialog.fileUrl.toString())
        }
        onRejected: {
            statusText.text = "Delete operation cancelled"
        }
    }

    // Function to clear all form fields
    function clearAllFields() {
        // Clear Personal Profile fields
        personalProfile.clearAllFields()

        // Clear Guardian Information fields
        guardianInfo.clearAllFields()

        // Clear Academic Details fields
        academicDetails.clearAllFields()
    }

    // Function to save student data to text file
    function saveStudentData() {
        var courseNames = academicDetails.getCourseNames()
        var passingYears = academicDetails.getPassingYears()
        var percentages = academicDetails.getPercentages()
        var boardUniversities = academicDetails.getBoardUniversities()

        var contactNoNum = personalProfile.contactNo ? Number(personalProfile.contactNo) : 0
        var guardianContactNoNum = guardianInfo.guardianContactNo ? Number(guardianInfo.guardianContactNo) : 0

        studentModel.saveToTextFile(
                    personalProfile.scholarNo, personalProfile.admissionNo, personalProfile.studentName,
                    personalProfile.rollNo, personalProfile.dateOfAdmission, personalProfile.gender,
                    personalProfile.religion, personalProfile.nationality, personalProfile.fathersName,
                    personalProfile.mothersName, personalProfile.address, personalProfile.course,
                    personalProfile.branch, personalProfile.semester, personalProfile.section,
                    personalProfile.documents, contactNoNum, personalProfile.emailId,
                    personalProfile.photoPath, guardianInfo.guardianName, guardianContactNoNum,
                    guardianInfo.guardianAddress, courseNames, passingYears, percentages, boardUniversities
                    )
    }

    // Function to print current data to console
    function printCurrentData() {
        var courseNames = academicDetails.getCourseNames()
        var passingYears = academicDetails.getPassingYears()
        var percentages = academicDetails.getPercentages()
        var boardUniversities = academicDetails.getBoardUniversities()

        var contactNoNum = personalProfile.contactNo ? Number(personalProfile.contactNo) : 0
        var guardianContactNoNum = guardianInfo.guardianContactNo ? Number(guardianInfo.guardianContactNo) : 0

        studentModel.printCurrentData(
                    personalProfile.scholarNo, personalProfile.admissionNo, personalProfile.studentName,
                    personalProfile.rollNo, personalProfile.dateOfAdmission, personalProfile.gender,
                    personalProfile.religion, personalProfile.nationality, personalProfile.fathersName,
                    personalProfile.mothersName, personalProfile.address, personalProfile.course,
                    personalProfile.branch, personalProfile.semester, personalProfile.section,
                    personalProfile.documents, contactNoNum, personalProfile.emailId,
                    personalProfile.photoPath, guardianInfo.guardianName, guardianContactNoNum,
                    guardianInfo.guardianAddress, courseNames, passingYears, percentages, boardUniversities
                    )
    }

    // Function to load data into all form fields
    function loadDataIntoFields(scholarNo, admissionNo, studentName, rollNo, dateOfAdmission,
                                gender, religion, nationality, fathersName, mothersName, address,
                                course, branch, semester, section, documents, contactNo, emailId,
                                photoPath, guardianName, guardianContactNo, guardianAddress,
                                courseNames, passingYears, percentages, boardUniversities) {

        // Load Personal Profile data
        personalProfile.loadPersonalData(scholarNo, admissionNo, studentName, rollNo, dateOfAdmission,
                                         gender, religion, nationality, fathersName, mothersName, address, course,
                                         branch, semester, section, documents, contactNo, emailId, photoPath)

        // Load Guardian Information data
        guardianInfo.loadGuardianData(guardianName, guardianContactNo, guardianAddress)

        // Load Academic Details data
        academicDetails.loadAcademicData(courseNames, passingYears, percentages, boardUniversities)
    }
}

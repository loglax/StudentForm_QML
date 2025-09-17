import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Layouts 1.12
import "."

Rectangle {
    id: academicDetailsRect
    width: 950
    height: 400
    color: "skyblue"
    border.color: "black"
    border.width: 2
    radius: 10

    // Properties to make form data accessible from outside
    property alias course1: course1.text
    property alias course2: course2.text
    property alias percentage1: percentage1.text
    property alias percentage2: percentage2.text
    property alias percentage3: percentage3.text
    property alias percentage4: percentage4.text
    property alias board1: board1.text
    property alias board2: board2.text
    property alias board3: board3.text
    property alias board4: board4.text

    // Properties for ComboBox values
    property string degree1: degree1Combo.currentText
    property string degree2: degree2Combo.currentText
    property string passingYear1: passingYear1Combo.currentText
    property string passingYear2: passingYear2Combo.currentText
    property string passingYear3: passingYear3Combo.currentText
    property string passingYear4: passingYear4Combo.currentText

    // Function to get course names as list
    function getCourseNames() {
        return [course1.text, course2.text, degree1Combo.currentText, degree2Combo.currentText];
    }

    // Function to get passing years as list
    function getPassingYears() {
        return [passingYear1Combo.currentText, passingYear2Combo.currentText,
                passingYear3Combo.currentText, passingYear4Combo.currentText];
    }

    // Function to get percentages as list
    function getPercentages() {
        return [Number(percentage1.text) || 0.0,
                Number(percentage2.text) || 0.0,
                Number(percentage3.text) || 0.0,
                Number(percentage4.text) || 0.0];
    }

    // Function to get boards/universities as list
    function getBoardUniversities() {
        return [board1.text, board2.text, board3.text, board4.text];
    }

    // Function to clear all academic fields
    function clearAllFields() {
        course1.text = ""
        course2.text = ""
        percentage1.text = ""
        percentage2.text = ""
        percentage3.text = ""
        percentage4.text = ""
        board1.text = ""
        board2.text = ""
        board3.text = ""
        board4.text = ""
        degree1Combo.currentIndex = 0
        degree2Combo.currentIndex = 0
        passingYear1Combo.currentIndex = 0
        passingYear2Combo.currentIndex = 0
        passingYear3Combo.currentIndex = 0
        passingYear4Combo.currentIndex = 0
    }

    // Function to load academic data from file
    function loadAcademicData(courseNames, passingYears, percentages, boardUniversities) {
        // Clear first
        clearAllFields()

        // Load course names
        if (courseNames && courseNames.length > 0) course1.text = courseNames[0] || ""
        if (courseNames && courseNames.length > 1) course2.text = courseNames[1] || ""
        if (courseNames && courseNames.length > 2) {
            var degreeIndex = degree1Combo.find(courseNames[2])
            if (degreeIndex >= 0) degree1Combo.currentIndex = degreeIndex
        }
        if (courseNames && courseNames.length > 3) {
            var degree2Index = degree2Combo.find(courseNames[3])
            if (degree2Index >= 0) degree2Combo.currentIndex = degree2Index
        }

        // Load passing years
        if (passingYears && passingYears.length > 0) {
            var year1Index = passingYear1Combo.find(passingYears[0])
            if (year1Index >= 0) passingYear1Combo.currentIndex = year1Index
        }
        if (passingYears && passingYears.length > 1) {
            var year2Index = passingYear2Combo.find(passingYears[1])
            if (year2Index >= 0) passingYear2Combo.currentIndex = year2Index
        }
        if (passingYears && passingYears.length > 2) {
            var year3Index = passingYear3Combo.find(passingYears[2])
            if (year3Index >= 0) passingYear3Combo.currentIndex = year3Index
        }
        if (passingYears && passingYears.length > 3) {
            var year4Index = passingYear4Combo.find(passingYears[3])
            if (year4Index >= 0) passingYear4Combo.currentIndex = year4Index
        }

        // Load percentages
        if (percentages && percentages.length > 0) percentage1.text = String(percentages[0])
        if (percentages && percentages.length > 1) percentage2.text = String(percentages[1])
        if (percentages && percentages.length > 2) percentage3.text = String(percentages[2])
        if (percentages && percentages.length > 3) percentage4.text = String(percentages[3])


        // Load board/universities
        if (boardUniversities && boardUniversities.length > 0) board1.text = boardUniversities[0] || ""
        if (boardUniversities && boardUniversities.length > 1) board2.text = boardUniversities[1] || ""
        if (boardUniversities && boardUniversities.length > 2) board3.text = boardUniversities[2] || ""
        if (boardUniversities && boardUniversities.length > 3) board4.text = boardUniversities[3] || ""
    }

    Column {
        spacing: 20
        anchors.fill: parent
        anchors.margins: 20

        Text {
            text: "Academic Details"
            font.family: "Sans-Serif"
            font.bold: true
            font.pixelSize: 36
            anchors.horizontalCenter: parent.horizontalCenter
        }

        Row {
            spacing: 50
            anchors.horizontalCenter: parent.horizontalCenter

            Column {
                spacing: 10
                Text {
                    text: "Course Name"
                    font.pixelSize: 16
                }
                TextField {
                    id: course1
                    height: 40
                    width: 180
                    placeholderText: "Enter course 1"
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: course2
                    height: 40
                    width: 180
                    placeholderText: "Enter course 2"
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                CustomComboBox {
                    id: degree1Combo
                    width: 180
                    model: ["BSc", "BCom", "BCA", "BTech", "BE"]
                    currentIndex: 0
                }
                CustomComboBox {
                    id: degree2Combo
                    width: 180
                    model: ["MSc", "MCom", "MCA", "MTech", "ME"]
                    currentIndex: 0
                }
            }

            Column {
                spacing: 10
                Text {
                    text: "Year of Passing"
                    font.pixelSize: 16
                }
                CustomComboBox {
                    id: passingYear1Combo
                    width: 180
                    model: ["2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018"]
                    currentIndex: 0
                }
                CustomComboBox {
                    id: passingYear2Combo
                    width: 180
                    model: ["2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018"]
                    currentIndex: 0
                }
                CustomComboBox {
                    id: passingYear3Combo
                    width: 180
                    model: ["2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018"]
                    currentIndex: 0
                }
                CustomComboBox {
                    id: passingYear4Combo
                    width: 180
                    model: ["2025", "2024", "2023", "2022", "2021", "2020", "2019", "2018"]
                    currentIndex: 0
                }
            }

            Column {
                spacing: 10
                Text { text: "Percentage"
                    font.pixelSize: 16
                }
                TextField {
                    id: percentage1
                    height: 40
                    width: 180
                    placeholderText: "Enter %"
                    validator: RegExpValidator { regExp: /^[0-9]+(\.[0-9]{1,2})?$/ }
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: percentage2
                    height: 40
                    width: 180
                    placeholderText: "Enter %"
                    validator: RegExpValidator { regExp: /^[0-9]+(\.[0-9]{1,2})?$/ }
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: percentage3
                    height: 40
                    width: 180
                    placeholderText: "Enter %"
                    validator: RegExpValidator { regExp: /^[0-9]+(\.[0-9]{1,2})?$/ }
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: percentage4
                    height: 40
                    width: 180
                    placeholderText: "Enter %"
                    validator: RegExpValidator { regExp: /^[0-9]+(\.[0-9]{1,2})?$/ }
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
                Text { text: "Board / University"
                    font.pixelSize: 16
                }
                TextField {
                    id: board1
                    height: 40
                    width: 180
                    placeholderText: "Enter board"
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: board2
                    height: 40
                    width: 180
                    placeholderText: "Enter board"
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: board3
                    height: 40
                    width: 180
                    placeholderText: "Enter board"
                    background: Rectangle {
                        color: "white"
                        border.color: parent.activeFocus ? "blue" : "black"
                        border.width: 1
                        radius: 4
                    }
                }
                TextField {
                    id: board4
                    height: 40
                    width: 180
                    placeholderText: "Enter board"
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
}

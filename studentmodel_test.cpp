#include <gtest/gtest.h>
#include <QDir>
#include "studentmodel.h"

QtMessageHandler previousHandler;
void suppressDebugOutput(QtMsgType, const QMessageLogContext &, const QString &)
{

}

TEST(StudentModelTest, ClearAllFields) {
    StudentModel model;
    // Simulate filling some data
    //Personal Details
    model.setScholarNo("S105");
    model.setAdmissionNo("A105");
    model.setStudentName("Test Name");
    //Guardian Section
    model.setGuardianName("Guardian Name");
    model.setGuardianContactNo(9876543210);
    //Academic Details
    model.setCourseNames({"Course1", "Course2"});
    model.setPassingYears({"Year1", "Year2"});
    model.setPercentages({85, 90});
    model.setBoardUniversities({"University1", "University2"});

    model.clearAllFields();

    EXPECT_TRUE(model.allfieldsEmpty());
}

//Open existing record
TEST(StudentModelTest, LoadFromTextFile_Exists) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    QString docDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QString file = docDir + "/student_3434.txt";

    StudentModel model;
    bool loaded = model.loadFromTextFile(file);
    EXPECT_TRUE(loaded);

    qInstallMessageHandler(previousHandler);
}

//Open non existing record
TEST(StudentModelTest, LoadFromTextFile_FileNotExists) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    StudentModel model;
    // Ensure file does not exist
    QFile::remove("student_S999.txt");
    bool loaded = model.loadFromTextFile("student_S999.txt");
    EXPECT_FALSE(loaded);

    qInstallMessageHandler(previousHandler);
} 

// This test checks that saving with all valid fields works
TEST(StudentModelTest, SaveToTextFile_ValidData) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    StudentModel model;
 
    // Save in the build/tests directory to avoid polluting Documents
    QString docDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);

    QString fileName = QString("student_%1.txt").arg("S104");
    QString filePath = docDir + "/" + fileName;
 
    // Remove the file if it exists from a previous run
    QFile::remove(filePath);
 
    bool saved = model.saveToTextFile(
        "S104","A004","Karthick","R102","2023-08-24","Male","Hindu","Indian","Father Name",
        "Mother Name","Test Address","BSc","CS","5","A","10th,12th",1234567890,"email@test.com","", 
        "Guardian Name",9876543210,"Guardian Address",
        {"SSLC","HSC","BSc", "MSc"},
        {"2018", "2020","2023","2025"},
        {85, 90,95,92},
        {"StateBoard", "StateBoard", "Periyar University", "Anna University"}
    );

    // The function should return true
    EXPECT_TRUE(saved);
 
    // The file should now exist in the build directory
    QFile file(filePath);
    EXPECT_TRUE(file.exists());

    qInstallMessageHandler(previousHandler);
}

//Save with Missing Scholar No
TEST(StudentModelTest, SaveToTextFile_EmptyScholarNo) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    StudentModel model;
    bool saved = model.saveToTextFile(
        "", // empty scholarNo
        "A001", "Test Name", "R101", "2023-08-24", "Male", "Hindu", "Indian",
        "Father Name", "Mother Name", "Address", "BCA", "CS", "5", "A", "Docs",
        1234567890, "email@example.com", "", "Guardian", 9876543210, "GAddress",
        {"SSLC","HSC","BSc", "MSc",}, 
        {"2018", "2020", "2023", "2025"}, 
        {85, 90, 89, 92}, 
        {"StateBoard", "StateBoard", "Periyar University", "Anna University"}
    );
    EXPECT_FALSE(saved);

    qInstallMessageHandler(previousHandler);
}
/*
//Delete existing File
TEST(StudentModelTest, DeleteTextFile_ExistingFile) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    StudentModel model;
    QString docDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QString fileName = "student_S104.txt";
    QString filePath = docDir + "/" + fileName;
    //Create the file in Documents folder so it can be deleted
    QFile file("student_S104.txt");
    file.open(QIODevice::WriteOnly); // Make sure file exists
    file.close();
    bool deleted = model.deleteTextFile(filePath);
    EXPECT_TRUE(deleted);
    EXPECT_FALSE(QFile::exists(filePath));

    qInstallMessageHandler(previousHandler);
}
*/
//Delete Non existing file
TEST(StudentModelTest, DeleteTextFile_NonexistentFile) {
    StudentModel model;
    QString docDir = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    QString fileName = "student_S111.txt";
    QString filepath = docDir + "/" + fileName;
    QFile::remove(filepath); // Ensure doesn't exist
    bool deleted = model.deleteTextFile(filepath);
    EXPECT_FALSE(deleted);
}

//PrintData
TEST(StudentModelTest, PrintCurrentData) {

    previousHandler = qInstallMessageHandler(suppressDebugOutput);

    StudentModel model;

    model.printCurrentData("S103","A002","Karthick","R102","2023-08-24","Male","Hindu","Indian","Father Name",
        "Mother Name","Test Address","BSc","CS","5","A","10th,12th",1234567890,"email@test.com","", 
        "Guardian Name",9876543210,"Guardian Address",
        {"SSLC","HSC","BSc", "MSc"},
        {"2018","2020","2023","2025"},
        {85,90,95,92},
        {"StateBoard", "StateBoard", "Periyar University", "Anna University"});

    qInstallMessageHandler(previousHandler);
    
}
int main(int argc, char **argv)
{
    testing::InitGoogleTest(&argc, argv);
    return RUN_ALL_TESTS();
}
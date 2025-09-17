#include "studentmodel.h"
#include <QFileInfo>
#include <QDir>

StudentModel::StudentModel(QObject *parent)
    : QAbstractListModel(parent)
{
}

int StudentModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent)
    return m_data.size();
}

QVariant StudentModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || index.row() >= m_data.size())
        return QVariant();

    const QString &item = m_data[index.row()];

    switch (role) {
    case ScholarNoRole:
        return item;
    case StudentNameRole:
        return item;
    case CourseRole:
        return item;
    default:
        return QVariant();
    }
}

QHash<int, QByteArray> StudentModel::roleNames() const
{
    QHash<int, QByteArray> roles;
    roles[ScholarNoRole] = "scholarNo";
    roles[StudentNameRole] = "studentName";
    roles[CourseRole] = "course";
    return roles;
}

void StudentModel::clearAllFields()
{
    m_cachedScholarNo.clear();
    m_cacahedAdmissionNo.clear();
    m_cachedStudentName.clear();
    m_cachedRollNo.clear();
    m_cachedDateOfAdmission.clear();
    m_cachedGender.clear();
    m_cachedReligion.clear();
    m_cachedNationality.clear();
    m_cachedFathersName.clear();
    m_cachedMothersName.clear();
    m_cachedAddress.clear();
    m_cachedCourse.clear();
    m_cachedBranch.clear();
    m_cachedSemester.clear();
    m_cachedSection.clear();
    m_cachedDocuments.clear();
    m_cachedContactNo = 0;
    m_cachedEmailId.clear();
    m_cachedPhotoPath.clear();
    m_cachedGuardianName.clear();
    m_cachedGuardianContactNo = 0;
    m_cachedGuardianAddress.clear();
    m_cachedCourseNames.clear();
    m_cachedPassingYears.clear();
    m_cachedPercentages.clear();
    m_cachedBoardUniversities.clear();

    emit operationResult("All fields cleared successfully");
}

bool StudentModel::allfieldsEmpty()
const {
    return m_cachedScholarNo.isEmpty() &&
    m_cacahedAdmissionNo.isEmpty() &&
    m_cachedStudentName.isEmpty() &&
    m_cachedRollNo.isEmpty() &&
    m_cachedDateOfAdmission.isEmpty() &&
    m_cachedGender.isEmpty() &&
    m_cachedReligion.isEmpty() &&
    m_cachedNationality.isEmpty() &&
    m_cachedFathersName.isEmpty() &&
    m_cachedMothersName.isEmpty() &&
    m_cachedAddress.isEmpty() &&
    m_cachedCourse.isEmpty() &&
    m_cachedBranch.isEmpty() &&
    m_cachedSemester.isEmpty() &&
    m_cachedSection.isEmpty() &&
    m_cachedDocuments.isEmpty() &&
    m_cachedContactNo == 0 &&
    m_cachedEmailId.isEmpty() &&
    m_cachedPhotoPath.isEmpty() &&
    m_cachedGuardianName.isEmpty() &&
    m_cachedGuardianContactNo == 0 &&
    m_cachedGuardianAddress.isEmpty() &&
    m_cachedCourseNames.isEmpty() &&
    m_cachedPassingYears.isEmpty() &&
    m_cachedPercentages.isEmpty() &&
    m_cachedBoardUniversities.isEmpty();
}

void StudentModel::setSavePath(const QString &path)
{
    m_savePath = path;
}

QString StudentModel::escapeValue(const QString &value)
{
    QString escaped = value;
    escaped.replace("\\", "\\\\");
    escaped.replace("\n", "\\n");
    escaped.replace("\r", "\\r");
    escaped.replace("\t", "\\t");
    return escaped;
}

QString StudentModel::unescapeValue(const QString &value)
{
    QString unescaped = value;
    unescaped.replace("\\n", "\n");
    unescaped.replace("\\r", "\r");
    unescaped.replace("\\t", "\t");
    unescaped.replace("\\\\", "\\");
    return unescaped;
}

QString StudentModel::getDocumentsPath()
{
    QString documentsPath = QStandardPaths::writableLocation(QStandardPaths::DocumentsLocation);
    if (documentsPath.isEmpty()) {
        documentsPath = QDir::homePath() + "/Documents";
    }

    QDir dir(documentsPath);
    if (!dir.exists()) {
        dir.mkpath(documentsPath);
    }

    return documentsPath;
}

bool StudentModel::saveToTextFile(const QString &scholarNo, const QString &admissionNo, const QString &studentName,
                                  const QString &rollNo, const QString &dateOfAdmission, const QString &gender,
                                  const QString &religion, const QString &nationality, const QString &fathersName,
                                  const QString &mothersName, const QString &address, const QString &course,
                                  const QString &branch, const QString &semester, const QString &section,
                                  const QString &documents, qlonglong contactNo, const QString &emailId,
                                  const QString &photoPath, const QString &guardianName, qlonglong guardianContactNo,
                                  const QString &guardianAddress, const QStringList &courseNames, const QStringList &passingYears,
                                  const QList<double> &percentages, const QStringList &boardUniversities)
{
    if (scholarNo.isEmpty()) {
        emit operationResult("Error: Scholar Number is required for saving");
        return false;
    }

    QString documentsPath = m_savePath.isEmpty() ? getDocumentsPath() : m_savePath;
    QString fileName = QString("student_%1.txt").arg(scholarNo);
    QString filePath = documentsPath + "/" + fileName;

    QFile file(filePath);
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text)) {
        emit operationResult("Error: Could not create file " + filePath);
        return false;
    }

    QTextStream out(&file);
    out.setCodec("UTF-8");

    // Write header
    out << "====================================\n";
    out << "STUDENT INFORMATION RECORD\n";
    out << "====================================\n";
    out << "\n";

    // Write Personal Profile
    out << "PERSONAL PROFILE:\n";
    out << "Scholar Number     : " << escapeValue(scholarNo) << "\n";
    out << "Admission Number   : " << escapeValue(admissionNo) << "\n";
    out << "Student Name       : " << escapeValue(studentName) << "\n";
    out << "Roll Number        : " << escapeValue(rollNo) << "\n";
    out << "Date of Admission  : " << escapeValue(dateOfAdmission) << "\n";
    out << "Gender             : " << escapeValue(gender) << "\n";
    out << "Religion           : " << escapeValue(religion) << "\n";
    out << "Nationality        : " << escapeValue(nationality) << "\n";
    out << "Father's Name      : " << escapeValue(fathersName) << "\n";
    out << "Mother's Name      : " << escapeValue(mothersName) << "\n";
    out << "Address            : " << escapeValue(address) << "\n";
    out << "Course             : " << escapeValue(course) << "\n";
    out << "Branch             : " << escapeValue(branch) << "\n";
    out << "Semester           : " << escapeValue(semester) << "\n";
    out << "Section            : " << escapeValue(section) << "\n";
    out << "Documents          : " << escapeValue(documents) << "\n";
    out << "Contact Number     : " << QString::number(contactNo) << "\n";
    out << "Email ID           : " << escapeValue(emailId) << "\n";
    out << "Photo Path         : " << escapeValue(photoPath) << "\n";
    out << "\n";

    // Write Guardian Information
    out << "GUARDIAN INFORMATION:\n";
    out << "Guardian Name      : " << escapeValue(guardianName) << "\n";
    out << "Guardian Contact   : " << QString::number(guardianContactNo) << "\n";
    out << "Guardian Address   : " << escapeValue(guardianAddress) << "\n";
    out << "\n";

    // Convert percentages list to string list for joining
    QStringList percentagesStrList;
    for(double p : percentages) {
        percentagesStrList.append(QString::number(p));
    }

    // Write Academic Details
    out << "ACADEMIC DETAILS:\n";
    out << "Course Names       : " << courseNames.join("|") << "\n";
    out << "Passing Years      : " << passingYears.join("|") << "\n";
    out << "Percentages        : " << percentagesStrList.join("|") << "\n";
    out << "Board Universities : " << boardUniversities.join("|") << "\n";

    file.close();

    emit operationResult("Student record saved successfully to: " + fileName);
    qDebug() << "File saved to:" << filePath;
    return true;
}

bool StudentModel::loadFromTextFile(const QString &filePath)
{
    qDebug() << "Loading from file path:" << filePath;

    if (filePath.isEmpty()) {
        qDebug() << "Error: File path is empty";
        emit operationResult("Error: No file path provided");
        return false;
    }

    // Convert URL path to local path if needed
    QString localPath = filePath;
    if (localPath.startsWith("file:///")) {
        // Use QUrl for proper conversion
        QUrl url(filePath);
        localPath = url.toLocalFile();
    } else if (localPath.startsWith("file://")) {
        QUrl url(filePath);
        localPath = url.toLocalFile();
    }

    qDebug() << "Converted local path:" << localPath;

    QFile file(localPath);
    if (!file.exists()) {
        qDebug() << "Error: File does not exist:" << localPath;
        emit operationResult("Error: File does not exist: " + localPath);
        return false;
    }

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)) {
        qDebug() << "Error: Could not open file:" << localPath;
        emit operationResult("Error: Could not open file " + localPath);
        return false;
    }

    QTextStream in(&file);
    in.setCodec("UTF-8");
    QString content = in.readAll();
    file.close();

    qDebug() << "File content loaded, size:" << content.length();
    // qDebug() << "First 200 characters:" << content.left(200);

    // Parse the content and extract field values
    QString scholarNo, admissionNo, studentName, rollNo, dateOfAdmission;
    QString gender, religion, nationality, fathersName, mothersName;
    QString address, course, branch, semester, section, documents;
    qlonglong contactNo = 0; QString emailId, photoPath;
    QString guardianName; qlonglong guardianContactNo = 0; QString guardianAddress;
    QStringList courseNames, passingYears, boardUniversities;
    QList<double> percentages;

    // Simple parsing - look for each field
    QStringList lines = content.split('\n');

    for (const QString &line : lines) {
        QString trimmedLine = line.trimmed();

        // Parse each field by looking for the pattern "Field Name: Value"
        if (trimmedLine.startsWith("Scholar Number     : ")) {
            scholarNo = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Admission Number   : ")) {
            admissionNo = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Student Name       : ")) {
            studentName = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Roll Number        : ")) {
            rollNo = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Date of Admission  : ")) {
            dateOfAdmission = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Gender             : ")) {
            gender = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Religion           : ")) {
            religion = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Nationality        : ")) {
            nationality = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Father's Name      : ")) {
            fathersName = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Mother's Name      : ")) {
            mothersName = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Address            : ")) {
            address = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Course             : ")) {
            course = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Branch             : ")) {
            branch = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Semester           : ")) {
            semester = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Section            : ")) {
            section = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Documents          : ")) {
            documents = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Contact Number     : ")) {
            contactNo = trimmedLine.mid(21).toLongLong();
        } else if (trimmedLine.startsWith("Email ID           : ")) {
            emailId = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Photo Path         : ")) {
            photoPath = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Guardian Name      : ")) {
            guardianName = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Guardian Contact   : ")) {
            guardianContactNo = trimmedLine.mid(21).toLongLong();
        } else if (trimmedLine.startsWith("Guardian Address   : ")) {
            guardianAddress = unescapeValue(trimmedLine.mid(21));
        } else if (trimmedLine.startsWith("Course Names       : ")) {
            courseNames = trimmedLine.mid(21).split("|");
        } else if (trimmedLine.startsWith("Passing Years      : ")) {
            passingYears = trimmedLine.mid(21).split("|");
        } else if (trimmedLine.startsWith("Percentages        : ")) {
            QStringList pList = trimmedLine.mid(21).split("|");
            for(const QString &pStr : pList) {
                bool ok;
                double p = pStr.toDouble(&ok);
                if (ok) {
                    percentages.append(p);
                }
            }
        } else if (trimmedLine.startsWith("Board Universities : ")) {
            boardUniversities = trimmedLine.mid(21).split("|");
        }
    }

    // Debug the parsed data
    qDebug() << "Parsed data";
    qDebug() << "Scholar No:" << scholarNo;

    // Emit signal with all the loaded data
    emit fieldDataLoaded(scholarNo, admissionNo, studentName,
                         rollNo, dateOfAdmission, gender,
                         religion, nationality, fathersName,
                         mothersName, address, course,
                         branch, semester, section,
                         documents, contactNo, emailId,
                         photoPath, guardianName, guardianContactNo,
                         guardianAddress, courseNames, passingYears,
                         percentages, boardUniversities);

    qDebug() << "Student record loaded successfully from file";
    emit operationResult("Student record loaded successfully from file");
    return true;
}

bool StudentModel::deleteTextFile(const QString &filePath)
{
    if (filePath.isEmpty()) {
        emit operationResult("Error: No file path provided for deletion");
        return false;
    }

    // Convert URL to local path if necessary
    QString localPath = filePath;
    if (localPath.startsWith("file:///")) {
        QUrl url(filePath);
        localPath = url.toLocalFile();
    } else if (localPath.startsWith("file://")) {
        QUrl url(filePath);
        localPath = url.toLocalFile();
    }

    QFile file(localPath);
    if (!file.exists()) {
        emit operationResult("Error: File does not exist: " + localPath);
        return false;
    }

    if (file.remove()) {
        emit operationResult("Student record file deleted successfully");
        qDebug() << "File deleted:" << localPath;
        return true;
    } else {
        emit operationResult("Error: Could not delete file: " + localPath);
        return false;
    }
}

void StudentModel::printCurrentData(const QString &scholarNo, const QString &admissionNo, const QString &studentName,
                                    const QString &rollNo, const QString &dateOfAdmission, const QString &gender,
                                    const QString &religion, const QString &nationality, const QString &fathersName,
                                    const QString &mothersName, const QString &address, const QString &course,
                                    const QString &branch, const QString &semester, const QString &section,
                                    const QString &documents, qlonglong contactNo, const QString &emailId,
                                    const QString &photoPath, const QString &guardianName, qlonglong guardianContactNo,
                                    const QString &guardianAddress, const QStringList &courseNames, const QStringList &passingYears,
                                    const QList<double> &percentages, const QStringList &boardUniversities)
{
    qDebug() << "==========================================";
    qDebug() << "STUDENT INFORMATION RECORD - CONSOLE PRINT";
    qDebug() << "==========================================";
    qDebug() << "";

    qDebug() << "PERSONAL PROFILE:";
    qDebug() << "Scholar Number     :" << scholarNo;
    qDebug() << "Admission Number   :" << admissionNo;
    qDebug() << "Student Name       :" << studentName;
    qDebug() << "Roll Number        :" << rollNo;
    qDebug() << "Date of Admission  :" << dateOfAdmission;
    qDebug() << "Gender             :" << gender;
    qDebug() << "Religion           :" << religion;
    qDebug() << "Nationality        :" << nationality;
    qDebug() << "Father's Name      :" << fathersName;
    qDebug() << "Mother's Name      :" << mothersName;
    qDebug() << "Address            :" << address;
    qDebug() << "Course             :" << course;
    qDebug() << "Branch             :" << branch;
    qDebug() << "Semester           :" << semester;
    qDebug() << "Section            :" << section;
    qDebug() << "Documents          :" << documents;
    qDebug() << "Contact Number     :" << contactNo;
    qDebug() << "Email ID           :" << emailId;
    qDebug() << "Photo Path         :" << photoPath;
    qDebug() << "";

    qDebug() << "GUARDIAN INFORMATION:";
    qDebug() << "Guardian Name      :" << guardianName;
    qDebug() << "Guardian Contact   :" << guardianContactNo;
    qDebug() << "Guardian Address   :" << guardianAddress;
    qDebug() << "";

    qDebug() << "ACADEMIC DETAILS:";
    qDebug() << "Course Names:";
    for (int i = 0; i < courseNames.size(); ++i) {
        qDebug() << "Course" << (i+1) << "          :" << courseNames[i];
    }
    qDebug() << "Passing Years:";
    for (int i = 0; i < passingYears.size(); ++i) {
        qDebug() << "Year" << (i+1) << "            :" << passingYears[i];
    }
    qDebug() << "Percentages:";
    for (int i = 0; i < percentages.size(); ++i) {
        qDebug() << "Percentage" << (i+1) << "      :" << percentages[i];
    }
    qDebug() << "Board/Universities:";
    for (int i = 0; i < boardUniversities.size(); ++i) {
        qDebug() << "Board" << (i+1) << "           :" << boardUniversities[i];
    }
    qDebug() << "====================================";

    emit operationResult("Student data printed to console successfully");
}

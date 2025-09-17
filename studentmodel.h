#ifndef STUDENTMODEL_H
#define STUDENTMODEL_H

#include <QObject>
#include <QAbstractListModel>
#include <QVariant>
#include <QString>
#include <QStringList>
#include <QFile>
#include <QTextStream>
#include <QStandardPaths>
#include <QUrl>
#include <QDebug>

class StudentModel : public QAbstractListModel
{
    Q_OBJECT

public:

    explicit StudentModel(QObject *parent = nullptr);

    void setScholarNo(const QString &val){
        m_cachedScholarNo = val;
    }
    void setAdmissionNo(const QString &val){
        m_cacahedAdmissionNo = val;
    }
    void setStudentName(const QString &val){
        m_cachedStudentName = val;
    }
    void setRollNo(const QString &val){
        m_cachedRollNo = val;
    }
    void setDateOfAdmission(const QString &val){
        m_cachedDateOfAdmission = val;
    }
    void setGender(const QString &val){
        m_cachedGender = val;
    }
    void setReligion(const QString &val){
        m_cachedReligion = val;
    }
    void setNationality(const QString &val){
        m_cachedNationality = val;
    }
    void setFathersName(const QString &val){
        m_cachedFathersName = val;
    }
    void setMothersName(const QString &val){
        m_cachedMothersName = val;
    }
    void setAddress(const QString &val){
        m_cachedAddress = val;
    }
    void setCourse(const QString &val){
        m_cachedCourse = val;
    }
    void setBranch(const QString &val){
        m_cachedBranch = val;
    }
    void setSemester(const QString &val){
        m_cachedSemester = val;
    }
    void setSection(const QString &val){
        m_cachedSection = val;
    }
    void setDocuments(const QString &val){
        m_cachedDocuments = val;
    }
    void setContactNo(const QString &val){
        m_cachedContactNo = val.toLongLong();
    }
    void setEmailId(const QString &val){
        m_cachedEmailId = val;
    }
    void setPhotoPath(const QString &val){
        m_cachedPhotoPath = val;
    }
    void setGuardianName(const QString &val){
        m_cachedGuardianName = val;
    }
    void setGuardianContactNo(const QString &val){
        m_cachedGuardianContactNo = val.toLongLong();
    }
    void setGuardianAddress(const QString &val){
        m_cachedGuardianAddress = val;
    }
    void setCourseNames(const QStringList &val){
        m_cachedCourseNames = val;
    }
    void setPassingYears(const QStringList &val){
        m_cachedPassingYears = val;
    }
    void setPercentages(const QList<double> &val){
        m_cachedPercentages = val;
    }
    void setBoardUniversities(const QStringList &val){
        m_cachedBoardUniversities = val;
    }


    bool allfieldsEmpty() const;
    private:
    QString m_cachedScholarNo;
    QString m_cacahedAdmissionNo;
    QString m_cachedStudentName;
    QString m_cachedRollNo;
    QString m_cachedDateOfAdmission;
    QString m_cachedGender;
    QString m_cachedReligion;
    QString m_cachedNationality;
    QString m_cachedFathersName;
    QString m_cachedMothersName;
    QString m_cachedAddress;
    QString m_cachedCourse;
    QString m_cachedBranch;
    QString m_cachedSemester;
    QString m_cachedSection;
    QString m_cachedDocuments;
    qlonglong m_cachedContactNo;
    QString m_cachedEmailId;
    QString m_cachedPhotoPath;
    QString m_cachedGuardianName;
    qlonglong m_cachedGuardianContactNo;
    QString m_cachedGuardianAddress;
    QStringList m_cachedCourseNames;
    QStringList m_cachedPassingYears;
    QList<double> m_cachedPercentages;
    QStringList m_cachedBoardUniversities;

    // QAbstractListModel interface
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;
    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;
    QHash<int, QByteArray> roleNames() const override;

    // Custom roles for our model
    enum StudentRoles {
        ScholarNoRole = Qt::UserRole + 1,
        StudentNameRole,
        CourseRole
    };

public slots:
    void clearAllFields();
    void setSavePath(const QString &path);
    bool saveToTextFile(const QString &scholarNo, const QString &admissionNo, const QString &studentName,
                        const QString &rollNo, const QString &dateOfAdmission, const QString &gender,
                        const QString &religion, const QString &nationality, const QString &fathersName,
                        const QString &mothersName, const QString &address, const QString &course,
                        const QString &branch, const QString &semester, const QString &section,
                        const QString &documents, qlonglong contactNo, const QString &emailId,
                        const QString &photoPath, const QString &guardianName, qlonglong guardianContactNo,
                        const QString &guardianAddress, const QStringList &courseNames, const QStringList &passingYears,
                        const QList<double> &percentages, const QStringList &boardUniversities);

    bool loadFromTextFile(const QString &filePath);
    bool deleteTextFile(const QString &filePath);

    void printCurrentData(const QString &scholarNo, const QString &admissionNo, const QString &studentName,
                          const QString &rollNo, const QString &dateOfAdmission, const QString &gender,
                          const QString &religion, const QString &nationality, const QString &fathersName,
                          const QString &mothersName, const QString &address, const QString &course,
                          const QString &branch, const QString &semester, const QString &section,
                          const QString &documents, qlonglong contactNo, const QString &emailId,
                          const QString &photoPath, const QString &guardianName, qlonglong guardianContactNo,
                          const QString &guardianAddress, const QStringList &courseNames, const QStringList &passingYears,
                          const QList<double> &percentages, const QStringList &boardUniversities);

signals:
    void operationResult(const QString &message);
    void fieldDataLoaded(const QString &scholarNo, const QString &admissionNo, const QString &studentName,
                         const QString &rollNo, const QString &dateOfAdmission, const QString &gender,
                         const QString &religion, const QString &nationality, const QString &fathersName,
                         const QString &mothersName, const QString &address, const QString &course,
                         const QString &branch, const QString &semester, const QString &section,
                         const QString &documents, qlonglong contactNo, const QString &emailId,
                         const QString &photoPath, const QString &guardianName, qlonglong guardianContactNo,
                         const QString &guardianAddress, const QStringList &courseNames, const QStringList &passingYears,
                         const QList<double> &percentages, const QStringList &boardUniversities);

private:

    QString m_scholarNo;
    QString m_admissionNo;
    QString m_studentName;
    QString m_rollNo;
    QString m_dateOfAdmission;
    QString m_gender;
    QString m_religion;
    QString m_nationality;
    QString m_fathersName;
    QString m_mothersName;
    QString m_address;
    QString m_course;
    QString m_branch;
    QString m_semester;
    QString m_section;
    QString m_documents;
    QString m_contactNo;
    QString m_emailId;
    QString m_photoPath;
    QString m_guardianName;
    QString m_guardianContactNo;
    QString m_guardianAddress;
    QStringList m_courseNames;
    QStringList m_passingYears;
    QList<double> m_percentages;
    QStringList m_boardUniversities;


    QString escapeValue(const QString &value);
    QString unescapeValue(const QString &value);
    QString getDocumentsPath();

    QStringList m_data; // For the list model functionality
    QString m_savePath;
};

#endif // STUDENTMODEL_H

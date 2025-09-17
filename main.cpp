#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>
#include "studentmodel.h"

int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);
    QGuiApplication app(argc, argv);

    // Set application information for QSettings
        QCoreApplication::setOrganizationName("Wipro");
        QCoreApplication::setOrganizationDomain("wipro.com");
        QCoreApplication::setApplicationName("StudentForm");

    // Register our custom type for QML
    qmlRegisterType<StudentModel>("StudentApp", 1, 0, "StudentModel");

    QQmlApplicationEngine engine;

    // Load the main QML file
    const QUrl url(QStringLiteral("qrc:/main.qml"));
    QObject::connect(&engine, &QQmlApplicationEngine::objectCreated,
                     &app, [url](QObject *obj, const QUrl &objUrl) {
        if (!obj && url == objUrl)
            QCoreApplication::exit(-1);
    }, Qt::QueuedConnection);
    engine.load(url);

    return app.exec();
}

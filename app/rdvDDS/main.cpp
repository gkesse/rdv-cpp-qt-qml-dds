#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QIcon>
#include "qrtiddshandler.h"

int main(int argc, char *argv[])
{
    QGuiApplication app(argc, argv);

    QGuiApplication::setApplicationName("rdv.dds");
    QGuiApplication::setApplicationDisplayName("rdvDDS");
    QGuiApplication::setApplicationVersion("1.0.0");
    QGuiApplication::setWindowIcon(QIcon(":/img/logo.png"));

    qmlRegisterType<QrtiDDShandler>("org.QrtiDDS", 1, 0, "QrtiDDShandler");

    QQmlApplicationEngine engine;
    QObject::connect(
        &engine,
        &QQmlApplicationEngine::objectCreationFailed,
        &app,
        []() { QCoreApplication::exit(-1); },
        Qt::QueuedConnection);
    engine.loadFromModule("rdv.dds", "Main");

    return app.exec();
}

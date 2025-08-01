#pragma once

#include <QObject>
#include <QString>
#include <ndds/ndds_cpp.h>

class QrtiDDS;
class QrtiDDSlistener;

class QrtiDDShandler : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString dataAccess WRITE writeData READ readData NOTIFY newRcvdDataAvailable)

    void setUp_rtiDDS_handler();
public:
    explicit QrtiDDShandler(QObject *parent = 0);
    ~QrtiDDShandler();

    QString readData();

signals:
    void newRcvdDataAvailable(QString data);
    void newSendDataAvailable(QString data);
public slots:
    void writeData(QString data);
    void readListenerData(QString data);

private:
    QrtiDDS              * rtiDDS;
    QrtiDDSlistener      * rtiDDSlistener;
    QString              rtiDDSrcvBuffer;
};

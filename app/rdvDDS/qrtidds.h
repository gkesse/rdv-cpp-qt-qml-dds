#pragma once

#include <QDebug>
#include <QObject>
#include <QString>
#include <ndds/ndds_cpp.h>
#include <ndds/ndds_namespace_cpp.h>

#define MAX_STRING_SIZE         1024

class QrtiDDSlistener;

class QrtiDDS : public QObject
{
    Q_OBJECT
public:
    explicit QrtiDDS(QObject *parent, QrtiDDSlistener *rtiDDSlistener);
    ~QrtiDDS();

    DDSDomainParticipant *  participant;
    DDSTopic *              topic;
    DDSDataWriter *         data_writer;
    DDSDataReader *         data_reader;
    DDSStringDataWriter *   string_writer;
    DDS_ReturnCode_t        retcode;
    QrtiDDSlistener *         rtiDDSlistener;
    char                    sample[MAX_STRING_SIZE];
    int                     main_result;

public slots:
    void publishDDS(QString data);

private:
    int setupQrtiDDS();
};

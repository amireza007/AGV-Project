
#include <QSqlDatabase>
#include <QSqlQuery>
#include <QStandardPaths>
#include "equipments.h"

static bool createConnection(){

    GlobalData::appdb = QSqlDatabase::addDatabase("QSQLITE");
    const QString s = QStandardPaths::writableLocation(QStandardPaths::RuntimeLocation).append("/generatedData.db");
    GlobalData::appdb.setDatabaseName(s);
    if (!GlobalData::appdb.open()){
        return false;
    }
    QSqlQuery query;
    query.exec("create table QCs (indx int primary key, locations varchar(10), jobs varchar(10))");
    query.exec("create table ContainerJobs (QC varchar(4), indx int primary key, verticalLoc int, Type varchar(1))");
    //one way of adding to db is through direct query and binding. Another one is with the help of SQlTableModel and QSqlRecord
    // query.prepare("insert into ContainerJobs (QC, indx, verticalLoc, Type) values (:QC, :indx, :verticalLoc, :Type)");
    // query.bindValue(":QC", "m1");
    // query.bindValue(":indx", 1);
    // query.bindValue(":verticalLoc", 30);
    // query.bindValue(":Type", "L");
    // query.exec();
    return true;
}

#ifndef CONTAINERJOBS_H
#define CONTAINERJOBS_H
#include "ui_containerjobs.h"
#include <QWidget>
#include <QSqlTableModel>
#include <QTableView>
#include "DATAFILE.h"
#include "equipments.h"

QT_BEGIN_NAMESPACE
namespace Ui {
class ContainerJobs;
}
QT_END_NAMESPACE

class ContainerJobs : public QWidget
{
    Q_OBJECT

public:
    ContainerJobs(QWidget *parent = nullptr);
    ~ContainerJobs();
    QSqlTableModel *model;
    QTableView* getTableView();
public slots:
    void setTheTable();
private:
    Ui::ContainerJobs *ui;


};

#endif // CONTAINERJOBS_H

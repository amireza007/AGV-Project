#ifndef CONTAINERJOBS_H
#define CONTAINERJOBS_H

#include <QWidget>
#include <QSqlTableModel>
#include <QTableView>

namespace Ui {
class ContainerJobs;
}

class ContainerJobs : public QWidget
{
    Q_OBJECT

public:
    explicit ContainerJobs(QWidget *parent = nullptr);
    ~ContainerJobs();
    Ui::ContainerJobs *ui;
    QSqlTableModel *model;
    QTableView *table;

};

#endif // CONTAINERJOBS_H

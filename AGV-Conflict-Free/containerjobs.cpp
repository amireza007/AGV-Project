#include "containerjobs.h"
#include "ui_containerjobs.h"
#include "equipments.h"
ContainerJobs::ContainerJobs(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::ContainerJobs)
{
    model = new QSqlTableModel(this, GlobalData::appdb);
    ui->setupUi(this);
    table = ui->tableView;
    // ui->
}

ContainerJobs::~ContainerJobs()
{
    delete ui;
}

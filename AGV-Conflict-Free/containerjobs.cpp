#include "containerjobs.h"
#include "equipments.h"
ContainerJobs::ContainerJobs(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::ContainerJobs)
{
    model = new QSqlTableModel(this, GlobalData::appdb);
    ui->setupUi(this);
}

ContainerJobs::~ContainerJobs()
{
    delete ui;
}

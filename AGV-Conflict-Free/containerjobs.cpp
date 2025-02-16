#include "containerjobs.h"
#include "ui_containerjobs.h"

ContainerJobs::ContainerJobs(QWidget *parent)
    : QWidget(parent)
    , ui(new Ui::ContainerJobs)
{
    ui->setupUi(this);
}

ContainerJobs::~ContainerJobs()
{
    delete ui;
}

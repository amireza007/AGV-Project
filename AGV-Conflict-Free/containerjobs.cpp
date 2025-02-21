#include "containerjobs.h"

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

QTableView* ContainerJobs::getTableView(){return ui->tableView;}

void ContainerJobs::setTheTable(){
    this->model->setTable("ContainerJobs");
    this->model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    this->model->select();
    int counter = -1;
    //an array of records SQlRecord should be setValue d in the model of ContainerJobsUi
    for(auto& rec: Datafile::port->records){
        this->model->insertRecord(++counter,rec);
    }
    this->getTableView()->setModel(this->model);
    show();

}

#include "mainwindow.h"
#include "./ui_mainwindow.h"
#include <QSqlRecord>
#include <QVariant>
#include <QSqlField>
//for running the bbapproach, use bbapproach::bbapproach(port)
MainWindow::MainWindow(QWidget *parent)
    : QMainWindow(parent)
    , ui(new Ui::MainWindow)
{
    ui->setupUi(this);
}

MainWindow::~MainWindow()
{
    delete ui;
}

void MainWindow::on_pushButton_pressed()
{
    int AGVNumber = ui->spinBox->value();
    int Cnumber = ui->spinBox_2->value();

    port = PortSimulation(Cnumber, AGVNumber);
    //our port must have the sqltablemodel to write to db.
    containerJobsUi = new ContainerJobs();
    containerJobsUi->model->setTable("ContainerJobs");
    containerJobsUi->model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    containerJobsUi->model->select();
    int counter = -1;
    //an array of records SQlRecord should be setValue d in the model of ContainerJobsUi
    for(auto& rec: port.records){
        containerJobsUi->model->insertRecord(++counter,rec);
    }

    containerJobsUi->ui->tableView->setModel(containerJobsUi->model);


    // rec.insert();
    // containerJobsUi->ui->tableView;
    // QTableView t = containerJobsUi->ui-;
    // containerJobsUi->model->setHeaderData()
    this->close();
    containerJobsUi->show();

}


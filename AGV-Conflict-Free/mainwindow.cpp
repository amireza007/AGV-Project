#include "mainwindow.h"
#include "./ui_mainwindow.h"

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
    containerJobsUi = new ContainerJobs();
    containerJobsUi->model->setTable("ContainerJobs");
    containerJobsUi->model->setEditStrategy(QSqlTableModel::OnManualSubmit);
    containerJobsUi->model->select();
    containerJobsUi->ui->tableView->setModel(containerJobsUi->model);
    // containerJobsUi->ui->tableView;
    // QTableView t = containerJobsUi->ui-;
    // containerJobsUi->model->setHeaderData()
    this->close();
    containerJobsUi->show();

}


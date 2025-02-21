#include "mainwindow.h"
#include "DATAFILE.h"

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

void MainWindow::on_GenButton_pressed()
{
    int AGVNumber = ui->spinBox->value();
    int Cnumber = ui->spinBox_2->value();

    Datafile::port = new PortSimulation(Cnumber, AGVNumber);
    //our port must have the sqltablemodel to write to db.    

    // rec.insert();
    // containerJobsUi->ui->tableView;
    // QTableView t = containerJobsUi->ui-;
    // containerJobsUi->model->setHeaderData()
    this->close();

}

QPushButton * MainWindow::GetGenButton(){return ui->GenButton;}

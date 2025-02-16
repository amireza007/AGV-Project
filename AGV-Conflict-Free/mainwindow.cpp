#include "mainwindow.h"
#include "./ui_mainwindow.h"
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
    int Cnumber = ui->spinBox->value();
    int AGVNumber = ui->spinBox_2->value();
    port = PortSimulation(Cnumber, AGVNumber);
    containerJobsUi = new ContainerJobs();
    close();
    containerJobsUi->show();

}


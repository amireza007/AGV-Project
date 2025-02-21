#include "mainwindow.h"
#include "ui_mainwindow.h"
#include <QApplication>
#include "connection.h"
#include "containerjobs.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    createConnection();
    MainWindow* w = new MainWindow();
    ContainerJobs* CJview = new ContainerJobs();

    QObject::connect(w->GetGenButton() ,&QPushButton::pressed , CJview, &ContainerJobs::setTheTable);
    //CJview->show();
    w->show();

    return a.exec();
}

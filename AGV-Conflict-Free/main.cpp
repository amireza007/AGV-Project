#include "mainwindow.h"
#include "DATAFILE.h"
#include <QApplication>
// #include "PortSimulation.h"
#include "connection.h"
#include "containerjobs.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    createConnection();
    MainWindow w;
    ContainerJobs CJview;
    w.show();

    return a.exec();
}

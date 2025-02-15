#include "mainwindow.h"
#include "DATAFILE.h"
#include <QApplication>
#include "PortSimulation.h"

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    PortSimulation portSimulation = PortSimulation(10,3);

    w.show();

    return a.exec();
}

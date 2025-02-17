#include "mainwindow.h"
#include "DATAFILE.h"
#include <QApplication>
// #include "PortSimulation.h"
int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    //PortSimulation p(30,2);
    w.show();

    return a.exec();
}

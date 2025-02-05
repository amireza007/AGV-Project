#include "mainwindow.h"
#include "DATAFILE.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    w.show();
    Experiment f = Experiment();

    return a.exec();
}

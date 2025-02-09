#include "mainwindow.h"
#include "DATAFILE.h"
#include <QApplication>

int main(int argc, char *argv[])
{
    QApplication a(argc, argv);
    MainWindow w;
    QObject::connect(&w, &MainWindow::valueChanged, &w, &MainWindow::on_spinBox_valueChanged);
    w.show();

    return a.exec();
}

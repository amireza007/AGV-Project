#ifndef MAINWINDOW_H
#define MAINWINDOW_H

#include <QMainWindow>
// #include "PortSimulation.h"
// #include "bbapproach.h"
#include <QPushButton>

QT_BEGIN_NAMESPACE
namespace Ui {
class MainWindow;
}
QT_END_NAMESPACE

class MainWindow : public QMainWindow
{
    Q_OBJECT

public:
    MainWindow(QWidget *parent = nullptr);
    ~MainWindow();

    QPushButton* GetGenButton();
private slots:

    void on_GenButton_pressed();

private:
    Ui::MainWindow *ui;

};
#endif // MAINWINDOW_H

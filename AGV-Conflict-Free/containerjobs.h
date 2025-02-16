#ifndef CONTAINERJOBS_H
#define CONTAINERJOBS_H

#include <QWidget>

namespace Ui {
class ContainerJobs;
}

class ContainerJobs : public QWidget
{
    Q_OBJECT

public:
    explicit ContainerJobs(QWidget *parent = nullptr);
    ~ContainerJobs();

private:
    Ui::ContainerJobs *ui;
};

#endif // CONTAINERJOBS_H

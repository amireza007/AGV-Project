#ifndef BBAPPROACH_H
#define BBAPPROACH_H
#include "BBDefs.h"
#include <tuple>
#include <iostream>
class BBApproach
{
public:
    BBApproach();
    ~BBApproach();
    void InitialSoltuion();
private:
    QVector<std::tuple<container,float,>>;
};

#endif // BBAPPROACH_H

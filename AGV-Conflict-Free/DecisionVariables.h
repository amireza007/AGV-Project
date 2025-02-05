#ifndef DECISIONVARIABLES_H
#define DECISIONVARIABLES_H
#include <iostream>
#include <QVector>
#include <map>
#include "equipments.h"

QVector<std::map<std::tuple<container,container>, int>> Z;
QVector<std::map<std::tuple<W,W>, int>> UAGV;


// AGV locations
QVector<std::map<std::tuple<W,int>,int>> PX;
QVector<std::map<std::tuple<W,int>,int>> PY;
QVector<std::map<std::tuple<W,int>,int>> PX0;
QVector<std::map<std::tuple<W,int>,int>> PY0;

// AGV time related decision variable
QVector<std::map<container, double>> TQ;
QVector<std::map<container, double>> TY;
QVector<std::map<W, double>> Tstart;
QVector<std::map<std::tuple<W,W>, double>> tAGV;
QVector<std::map<W,int>> X_Postion; //Can be used in R(m,i)
QVector<std::map<W,int>> Y_Postion;

#endif // DECISIONVARIABLES_H

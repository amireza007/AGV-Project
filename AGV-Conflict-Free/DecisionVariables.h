#ifndef DECISIONVARIABLES_H
#define DECISIONVARIABLES_H
#include <iostream>
#include <QVector>
#include <map>
#include <unordered_map>
#include "equipments.h"

struct z_op{
    container c1;
    container c2;
    AGV l;
    int index;
    z_op(container _c1, container _c2, AGV _l, int _index): c1(_c1), c2(_c2), l(_l),
        index(_index){}
};
struct cmp{
    bool operator()(const struct z_op& o1, const struct z_op& o2) const{
        return o1.index != o2.index;//
    }
};

struct ModelVariables {
    std::map<struct z_op, int, cmp> z;
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
    ModelVariables();

};
#endif // DECISIONVARIABLES_H

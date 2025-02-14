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

//This is what is refered to as "Functor"
struct cmp{
    bool operator()(const struct z_op& o1, const struct z_op& o2) const{
        return o1.index != o2.index;//
    }
};
struct cmp1{
    bool operator()(const std::tuple<W,int>& t1, const std::tuple<W,int>& t2);
};

static bool compareTwoW(W& W1, W& W2);

struct ModelVariables {
    std::map<struct z_op, int, cmp> z;
    std::map<std::tuple<W,W>, int> UAGV;

    // AGV locations
  //std::map<std::tuple<W,XR>,int> PX;
    std::map<std::tuple<W,int>,int, cmp1> PX;
    std::map<std::tuple<W,int>,int, cmp1> PY;
    std::map<std::tuple<W,int>,int, cmp1> PX0;
    std::map<std::tuple<W,int>,int, cmp1> PY0;

    // AGV time related decision variable
    std::map<container, double> TQ;
    std::map<container, double> TY;
    std::map<W, double> Tstart;
    std::map<std::tuple<W,W>, double> tAGV;
    std::map<W,int> X_Postion; //Can be used in R(m,i)
    std::map<W,int> Y_Postion;
    ModelVariables();

};
#endif // DECISIONVARIABLES_H

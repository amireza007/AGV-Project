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

//This is what is referred to as "Functor"
struct cmp{
    bool operator()(const struct z_op& o1, const struct z_op& o2) const{
        return o1.index != o2.index;//
    }
};
struct cmp1{
    bool operator()(const std::tuple<W,int>& t1, const std::tuple<W,int>& t2) const;
};

struct cmp2{
    bool operator()(const std::tuple<W,W>& t1, const std::tuple<W,W>& t2)const;
};

struct cmp3{
    bool operator()(const W& w1, const W& w2)const;
};

struct cmp4{
    bool operator()(const container& c1, const container& c2) const;
};

static bool compareWs(QVector<W> v1, QVector<W> v2);

struct ModelVariables {
    std::map<struct z_op, int, cmp> z;
    std::map<std::tuple<W,W>, int,cmp2> UAGV;

    // AGV locations
  //std::map<std::tuple<W,XR>,int> PX;
    std::map<std::tuple<W,int>,int, cmp1> PX;
    std::map<std::tuple<W,int>,int, cmp1> PY;
    std::map<std::tuple<W,int>,int, cmp1> PX0;
    std::map<std::tuple<W,int>,int, cmp1> PY0;

    // AGV time related decision variable
    std::map<container, double, cmp4> TQ;
    std::map<container, double, cmp4> TY;
    std::map<W, double, cmp3> Tstart;
    std::map<std::tuple<W,W>, double, cmp2> tAGV;
    std::map<W,int, cmp3> X_Postion; //Can be used in R(m,i)
    std::map<W,int, cmp3> Y_Postion;
    //This could be used for the first basis maybe?
    ModelVariables();

};
#endif // DECISIONVARIABLES_H

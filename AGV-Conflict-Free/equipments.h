#ifndef EQUIPMENTS_H
#define EQUIPMENTS_H
#include <iostream>
#include <QVector>
#include <QQueue>
#include <tuple>
#include <map>
#include "portlayout.h"

struct QuayCrane {
    int m; // the index
    QList<int> jobs;
    QList<int> locations;
    QuayCrane(int c,QList<int> _jobs, QList<int> _locations) : m(c), jobs(_jobs), locations(_locations){}
    QuayCrane(){}
};

enum action {a0 ,a1, a2, a3, a4};

struct container {
    std::tuple<int, int> c;//first int is QuayCrane.m! WHAT A BEAUTIFUL TUPLE!
    container(){}
    container(int m, int j, bool _Loading, int _InitLoc) : c(m,j), isLoading(_Loading), verticalLocation(_InitLoc)
    {
        // c = {m,i};
    }
    ~container(){}
    int index; //container number
    bool  isLoading; //This determines if container is loading or not!
    //according to QC m location and the block
    int verticalLocation;
};
struct cmp5{
    bool operator()(const container& c1, const container& c2);
};
struct Block{
    QVector<container> requestedContainers;  // this could be used for creating set \psi_2
    int AL_location;
    QVector<std::map<container,int, cmp5>> AL;
    int AR_location;
    QVector<std::map<container,int, cmp5>> AR;
    Block(){}
    Block(QVector<std::map<container,int,cmp5>> _AL, int  _AlL, QVector<std::map<container,int,cmp5>> _AR, int _ArL): AL(_AL), AL_location(_AlL), AR(_AR), AR_location(_ArL) {}
};

struct AGV {
    int l; // the index
    QVector<container> assignedContainers;
    int CompletionTimeC(); //T(l):CompletionTimeOfCurrentjob
    int num; //number of assigned containers to an AGV
    // int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
    AGV(int _l, QVector<container> _AC, int _CT, int _num): l(_l), assignedContainers(_AC), num(_num){}
    AGV(){}
};

typedef std::tuple<container,action> W; //set of actions on each container
typedef std::tuple<container,action> WH;
typedef std::tuple<container,action> WV;

#endif // EQUIPMENTS_H

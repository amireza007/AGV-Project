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
    std::tuple<QuayCrane, int> c;
    container(){}
    container(QuayCrane m, int j, bool _Loading) : c(m,j), isLoading(_Loading)
    {
        // c = {m,i};
    }
    ~container(){}
    int i; // which is jobs[i]
    int index; //container number
    bool  isLoading; //This determines if container is loading or not!
    //according to QC m location and the block
};
struct Block{
    QVector<container> requestedContainers;  // this could be used for creating set \psi_2
    QVector<std::map<container,int>> AL;
    QVector<std::map<container,int>> AR;
};

struct AGV {
    int l; // the index
    QVector<container> assignedContainers;
    int CompletionTimeC(); //T(l):CompletionTimeOfCurrentjob
    int num; //number of assigned containers to an AGV
    // int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
    AGV(int _l, QVector<container> _AC, int _CT, int _num): l(_l), assignedContainers(_AC), num(_num){}
};

typedef std::tuple<container,action> W; //set of actions on each container


#endif // EQUIPMENTS_H

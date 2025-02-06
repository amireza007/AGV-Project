#ifndef EQUIPMENTS_H
#define EQUIPMENTS_H
#include <iostream>
#include <QVector>
#include <QQueue>
#include <tuple>
#include <map>
struct QuayCrane {
    int m; // the index
    QList<int> jobs;
    QuayCrane(int c,QList<int> _jobs) : m(c), jobs(_jobs){}
    QuayCrane(){}
};

enum action {a0 ,a1, a2, a3, a4};

struct container {
    std::tuple<QuayCrane, int> c;
    container();
    container(QuayCrane m, int j, bool _Loading) : c(m,j), isLoading(_Loading) {
        // c = {m,i};
    }
    ~container(){}
    int i; // which is jobs[i]
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
    int CompletionTimeOfCurrentjob(); //T(l)
    int num; //number of assigned containers to an AGV
    // int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
};

typedef std::tuple<container,action> W; //set of actions on each container


#endif // EQUIPMENTS_H

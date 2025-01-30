#ifndef SIMULATIONDATA_H
#define SIMULATIONDATA_H
// #include <iostream>
#include <QVector>
#include <QQueue>
#include <tuple>
#include <map>
//set of QCs should be called QCBuffer,
//set of AGVs shold be called AGVBuffer

// Problem specific simulation data
struct QuayCrane {
    int m; // the index
    QQueue<int> jobs; // means first job is loading
};

struct W{//set of actions on each container

};

// int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
struct container {
    QuayCrane m;
    int i; // which is jobs[i]
    bool  isLoading;
    //according to QC m location and the block
    QVector<std::tuple<container, double>> S;//list of container op time
    QVector<std::map<double, QVector<W>>> R;// R(s(m,i), [routes])
    QVector<QVector<W>> BuildR(container &c);
};

struct Block{

    QVector<container> requestedContainers;  // this could be used for creating set \psi_2
    QVector<std::map<container,int>> AL;
    QVector<std::map<container,int>> AR;


};



struct AllContainers{
    QVector<container> L;       //Loading Containers
    QVector<container> D;       //unloading containers
    double tMin;                 //minimum operation time for containers without considering conflict, used for computing AGV scheme
};

struct AGV {
    int l; // the index
    QVector<std::tuple<QuayCrane, int>> assignedContainers;
    int CompletionTimeOfCurrentjob(); //T(l)
    int num; //number of assigned containers to an AGV

};

//port layout simulation data
// should be more interactive and customizable
int XR[23] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
int YR[10] = {1,2,3,4,5,6,7,8,9,10};
int YL[5] = {1,2,3,4,5};
int YS[5] = {6,7,8,9,10};

#endif // SIMULATIONDATA_H

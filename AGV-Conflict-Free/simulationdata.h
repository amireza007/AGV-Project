#ifndef SIMULATIONDATA_H
#define SIMULATIONDATA_H
// #include <iostream>
#include <QVector>
#include <tuple>
//set of QCs should be called QCBuffer,
//set of AGVs shold be called AGVBuffer

// Problem specific simulation data
struct QuayCrane {
    int m; // the index
    QVector<int> jobs; // means first job is loading
};

// int q;  //maximumNumberOfContainers conducted by each AGV
struct container {
    QuayCrane m;
    int i; // which is jobs[i]
    bool  Loading;
};

struct AllContainers{
    QVector<QuayCrane> L;   //Loading Containers
    QVector<QuayCrane> D;   //unloading containers
};

struct AGV {
    QVector<std::tuple<QuayCrane, int>> assignedContainers;
    int CompletionTimeOfCurrentjob(); //T(l)

};

//port layout simulation data
// should be more interactive and customizable
int XR[23] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
int YR[10] = {1,2,3,4,5,6,7,8,9,10};
int YL[5] = {1,2,3,4,5};
int YS[5] = {6,7,8,9,10};

#endif // SIMULATIONDATA_H

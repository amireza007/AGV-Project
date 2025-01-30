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
    QQueue<int> jobs;
};
enum action {a0 ,a1, a2, a3, a4};


// int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
struct container {
    QuayCrane m;
    int i; // which is jobs[i]
    bool  isLoading;
    //according to QC m location and the block
};

typedef std::tuple<container,QuayCrane,action> W; //set of actions on each container


struct Block{
    QVector<container> requestedContainers;  // this could be used for creating set \psi_2
    QVector<std::map<container,int>> AL;
    QVector<std::map<container,int>> AR;
};



struct AllContainers{
    QVector<container> L;       //Loading Containers
    QVector<container> D;       //unloading containers
    double tMin;                //minimum operation time for containers without considering conflict, used for computing AGV scheme

    ////////////// possibly bad!
    QVector<std::map<container, QVector<std::tuple<container, double>>>> S;//list of container op time
    QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> R;// R(s(m,i), [routes])
};

extern QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> BuildR(container &c);

struct AGV {
    int l; // the index
    QVector<std::tuple<QuayCrane, int>> assignedContainers;
    int CompletionTimeOfCurrentjob(); //T(l)
    int num; //number of assigned containers to an AGV
};

///////////////////////////////////////////////////////
//model specific parameters:

//port layout
int XR[23] = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23};
int YR[10] = {1,2,3,4,5,6,7,8,9,10};
int YL[5] = {1,2,3,4,5};
int YS[5] = {6,7,8,9,10};

//QC vertical path
typedef std::map<container, QVector<int>> O_Container;

//sequence of QCS and ASCs
typedef std::tuple<QuayCrane,container,QuayCrane,container> psi1;
typedef std::tuple<QuayCrane,container,QuayCrane,container> psi2;

#endif // SIMULATIONDATA_H

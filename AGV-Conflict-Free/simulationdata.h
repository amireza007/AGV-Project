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
    std::tuple<QuayCrane, int> c;
    container();
    container(QuayCrane m, int i, bool _Loading){
        c = {m,i};
        isLoading = _Loading;
    }
    ~container(){};
    int i; // which is jobs[i]
    bool  isLoading;
    //according to QC m location and the block
};

typedef std::tuple<container,action> W; //set of actions on each container
// {container, 0} i;
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
    QVector<container> assignedContainers;
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

QVector<std::map<container, double>> G_Q = {};//uniform(60,90)
QVector<std::map<container, double>> G_Y = {};//uniform(20,30)

//QC vertical path
QVector<std::map<container, QVector<int>>> O_Container;

//sequence of QCS and ASCs
QVector<std::tuple<container,container>> psi1;
QVector<std::tuple<container,container>> psi2;

////////////////////////////////////////////////////////
//Decision variables
//AGV Job Assignment
QVector<std::map<std::tuple<container,container>, int>> Z;

// AGV job sequence
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

#endif // SIMULATIONDATA_H

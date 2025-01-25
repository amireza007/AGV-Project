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

QVector<QVector<int>> schemes;


//Branch and bound simulation data
typedef struct node* node_p;
struct node {
    node_p pred;
    node_p child;
    // node_p right_sibling;
    // node_p left_sibling;
    // long subtree;

};


#endif // SIMULATIONDATA_H

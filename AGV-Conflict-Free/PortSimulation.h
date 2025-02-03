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
    QList<int> jobs;
    QuayCrane(int c,QList<int> _jobs) : m(c), jobs(_jobs){};
};
enum action {a0 ,a1, a2, a3, a4};


// int q = T_UB / tMin;  //maximumNumberOfContainers conducted by each AGV
struct container {
    std::tuple<QuayCrane, int> c;
    container();
    container(QuayCrane m, int j, bool _Loading) : c(m,j), isLoading(_Loading) {
        // c = {m,i};
    }
    ~container(){};
    //int i; // which is jobs[i]
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


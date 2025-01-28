#ifndef BBDEFS_H
#define BBDEFS_H
#include "simulationdata.h"
#include <map>
//Branch and bound approach simulation data
//BFS strategy is used
QVector<QVector<int>> schemes;

// auto route = {};
typedef struct v* v_p;
typedef struct N_T* N_TP;
struct v { //s node in N
    v_p pred;   // pointer to v or N_{(t-1)}??
    v_p child;
    QVector<container> assignedContainers;
    QVector<container> ToBeContainers; //C'_{(tau, v)} from QC.jobs
    AGV newlyAssignedAGV;
    // variables for determining Lower Bound of the node
    std::map<AGV, int> b;    //number of unassigned containers to agv l, could be determined with the help of schemes set!
    double t_min;   //shortes op time, retrieved from s(m,i) set, of ToBeContainers
    std::map<container, double> t_Container;    //Min time for newlyAssignedAGV conducting a container WCC
    void compute_t_container();
    // what decision variable to update after assinging (m,i) to l
};

struct N_T{ //set of nodes in height T
    int height; //tau
    N_TP pred;
    N_TP child;
    QVector<v> nodes; //bunch of vs
};

//R(m,i) are a set of actions
//R(m,i), set of routes for container (m,i), each route having a property S(m,i). This needs preprocessing!
//The problem is, finding all possible routes for a container, with respect to actions, definied in WV and WH. Also take a look at 6.1
//S(m,i), set of op time for container (m,i), listed from smalles to largest
// QVector<std::tuple<container,QVector

#endif // BBDEFS_H

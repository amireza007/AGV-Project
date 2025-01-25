#ifndef BBDEFS_H
#define BBDEFS_H
#include "simulationdata.h"

//Branch and bound simulation data

QVector<QVector<int>> schemes;

// auto route = {};
typedef struct node* node_p;

struct node {
    node_p pred;
    node_p child;
    // node_p right_sibling;
    // node_p left_sibling;
    // long subtree;

};
//R(m,i), set of routes for container (m,i), each route having a property S(m,i)
//S(m,i), set of op time for container (m,i), listed from smalles to largest
// QVector<std::tuple<container,QVector

#endif // BBDEFS_H

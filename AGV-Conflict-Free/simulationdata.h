#ifndef SIMULATIONDATA_H
#define SIMULATIONDATA_H
// #include <iostream>
#include <QVector>
#include <tuple>
typedef struct {
    QVector<std::tuple<int,char>> jobs; //(1,'L') means first job is loading
} QuayCrane;

struct {
    QVector<std::tuple<QuayCrane, int>> assignedContainers;
    int TimeOfCurrentjob();
    int q;  //maximumNumberOfContainers conducted by AGV
} AGV;

QVector<QVector<int>> schemes;

struct {

} container;

struct {


} node;


#endif // SIMULATIONDATA_H

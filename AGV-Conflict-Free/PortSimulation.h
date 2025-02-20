// #pragma once

#include <QVector>
#include <QQueue>
#include <tuple>
#include <map>
#include <QList>
#include <QSqlTableModel>
#include <QSqlRecord>
#include "DecisionVariables.h"
//set of QCs should be called QCBuffer,
//set of AGVs shold be called AGVBuffer

struct AllContainers{//these don't contain virtual containers
    QVector<container> allC;        //Loading Containers
    container c0 = container(0, 0,false,0);
    double tMin;                //minimum operation time for containers without considering conflict, used for computing AGV scheme

    ////////////// possibly bad!
    /// TODO compare

    QVector<std::map<container, QVector<std::tuple<container, double>>>> S;//list of container op time
    QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> R;// R(s(m,i), [routes])
};

class PortSimulation{
public:

    PortSimulation(int _CNumber,int _AGVNumber);
    PortSimulation(){}
    QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> BuildR(container &c);
    int CNumber;
    int AGVNumber;

    QList<QSqlRecord> records{};

    //Main equipments
    AllContainers containers;
    QuayCrane QCs[3];
    QList<AGV> B{};
    Block blocks[6];
    ///////////////////////////
    QVector<std::map<container, double, cmp4>> G_Q;//uniform(60,90)
    QVector<std::map<container, double, cmp4>> G_Y;//uniform(20,30)

    //QC vertical path
    QVector<std::map<container,int, cmp4>> O_Container; //deteremined by someone or randomly. int = container.verticalLocation
    //sequence of QCS and ASCs
    //
    QVector<std::pair<container,container>> psi1;
    QVector<std::pair<container,container>> psi2;
    ModelVariables modelVariables = ModelVariables();

    bool BelongToSameBlock(container &c1, container &c2);
    void JobGenerator();
    bool FeasibilityChecker();
    //job assignment and AGV scheme constraints
    bool cnstr_2();
    bool cnstr_3();
    bool cnstr_4_5();
    bool cnstr_6_7();

    //Location based constraints
    bool cnstr_8();

};

#include "DATAFILE.h"
#include <QList>

firstExperiment::firstExperiment(){
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
    QVector<std::map<container,int>> O_Container; //deteremined by someone

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


    QList<QuayCrane> QCs;
    QuayCrane qc1 = QuayCrane(2,{1,2});
    QCs.append(qc1);
    QuayCrane qc2 = QuayCrane(2,{1,2});
    QuayCrane qc3 = QuayCrane(3,{1,2,3});
    QCs.append(qc2);
    QCs.append(qc3);
}

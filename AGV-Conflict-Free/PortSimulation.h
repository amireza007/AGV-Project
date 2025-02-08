#include "equipments.h"
#include <QVector>
#include <QQueue>
#include <tuple>
#include <map>
#include "DecisionVariables.h"
//set of QCs should be called QCBuffer,
//set of AGVs shold be called AGVBuffer

struct AllContainers{//these don't contain virtual containers
    QVector<container> allC;        //Loading Containers
    container c0 = container(QuayCrane(0,{}), 0,false);
    double tMin;                //minimum operation time for containers without considering conflict, used for computing AGV scheme

    ////////////// possibly bad!
    QVector<std::map<container, QVector<std::tuple<container, double>>>> S;//list of container op time
    QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> R;// R(s(m,i), [routes])
};

class PortSimulation{
public:
    QVector<std::map<container, QVector<std::tuple<double, QVector<W>>>>> BuildR(container &c);
    PortSimulation(int _CNumber,int _AGVNumber);
    int CNumber;
    int AGVNumber;
    struct AllContainers containers;
    QuayCrane QCs[3];
    QVector<AGV> B;
    QVector<std::map<container, double>> G_Q;//uniform(60,90)
    QVector<std::map<container, double>> G_Y;//uniform(20,30)

    //QC vertical path
    QVector<std::map<container,int>> O_Container; //deteremined by someone
    //sequence of QCS and ASCs
    QVector<std::tuple<container,container>> psi1;
    QVector<std::tuple<container,container>> psi2;
    ModelVariables modelVariables = ModelVariables();
    void JobGenerator();
    bool FeasibilityChecker();
    //job assignment and AGV scheme constraints
    bool cnstr_2();
    bool cnstr_3();
    bool cnstr_4_5();
    bool cnstr_6();
    bool cnstr_7();

    //Location based constraints
    bool cnstr_8();

};

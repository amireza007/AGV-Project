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
    container c0 = container(0, 0,false,0);
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

    //Main equipments
    AllContainers containers;
    QuayCrane QCs[3];
    QVector<AGV> B;
    Block blocks[6];
    ///////////////////////////

    QVector<std::map<container, double>> G_Q;//uniform(60,90)
    QVector<std::map<container, double>> G_Y;//uniform(20,30)

    //QC vertical path
    QVector<std::map<container,int>> O_Container; //deteremined by someone or randomly. int = container.verticalLocation
    //sequence of QCS and ASCs
    QVector<std::pair<container,container>> psi1;
    QVector<std::pair<container,container>> psi2;
    ModelVariables modelVariables = ModelVariables();
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

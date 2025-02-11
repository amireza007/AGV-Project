#include "PortSimulation.h"
#include <memory>
#include <QRandomGenerator>
#include <ctime>
PortSimulation::PortSimulation(int _CNumber,int _AGVNumber) :CNumber(_CNumber), AGVNumber(_AGVNumber) {
    QCs[0] = QuayCrane(1,{0},{4,8,12});
    QCs[1] = QuayCrane(2,{0},{16,20,24});
    QCs[3] = QuayCrane(3,{0},{28,32});
    blocks[0] = Block({},1,{},5);
    blocks[1] = Block({},7,{},11);
    blocks[2] = Block({},13,{},17);
    blocks[3] = Block({},19,{},23);
    blocks[4] = Block({},25,{},29);
    blocks[5] = Block({},31,{},35);
    JobGenerator();
}

void PortSimulation::JobGenerator(){//this method should also initialize decision variables after the parameters of the model are built

    int numOfAGVs = 4;

    int numOfContainers = 10;
    QRandomGenerator rand = QRandomGenerator(time(NULL));//the seed
    int NLoadC = rand.bounded(1,11);
    int NDLoadC = numOfContainers - NLoadC;
    //start of job generation
    int LCIterator = 0;
    int DCIterator = 0;
    int randomQCPicker ;
    int randomBlockPicker ;
    int randomVertLoc;
    container randCont;
    while(++DCIterator <= NDLoadC){
        randomQCPicker = rand.bounded(0,3);
        QCs[randomQCPicker].m = randomQCPicker +1;
        QCs[randomQCPicker].jobs.append(QCs[randomQCPicker].jobs.last() + 1);
        if(randomQCPicker <= 1){ //QC[0] or QC[1] is selected, because these two have 3 vertical locations
            randomVertLoc = rand.bounded(0,3);
            randCont = container(randomQCPicker+1, QCs[randomQCPicker].jobs.last(),false,QCs[randomQCPicker].locations[randomVertLoc]);
        }else{ //QC[2] is selected
            randomVertLoc = rand.bounded(0,2);
            randCont = container(randomQCPicker+1, QCs[randomQCPicker].jobs.last(),false,QCs[randomQCPicker].locations[randomVertLoc]);
        }
    }
    while(++LCIterator <= NLoadC){
        randomBlockPicker = rand.bounded(0,6);

    }

    //updating psi_1, psi_2 and o_{(m,i)}
}

bool PortSimulation::cnstr_2(){
    //cnstr_2
    int index = 0; //index of operands of Z
    int sum = 0;
    foreach (container c1, containers.allC) {
        bool virtualContNow = true;
        foreach (AGV l, B) {
            std::unique_ptr<z_op> temp = std::make_unique<z_op>(c1,containers.c0,l,++index);
            sum += modelVariables.z[*temp];
        }
        foreach (container c2, containers.allC) {
            foreach (AGV l, B) {
                std::unique_ptr<z_op> temp = std::make_unique<z_op>(c1,c2,l,++index);
                sum += modelVariables.z[*temp];
            }
        }
    }
    if (sum == 1) return true;
    else return false;

}

bool PortSimulation::cnstr_3(){
    int index = 0;
    int indexRHS = 0;
    int indexLHS = 0;
    int rhsSum = 0;
    int lhsSum = 0;
    foreach (container c1, containers.allC) {//write with unique_ptr!
        foreach(AGV l, B){
            //TODO compute sums in two threads
            {
                std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(containers.c0,c1,l,++index);
                std::unique_ptr<z_op> temp2 = std::make_unique<z_op>(c1,containers.c0,l, ++index);
                rhsSum += modelVariables.z[*temp1];
                lhsSum += modelVariables.z[*temp2];
            }
            foreach(container c2, containers.allC){
                std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(c2,c1,l,++index);
                std::unique_ptr<z_op> temp2= std::make_unique<z_op>(c1,c2,l,++index);
                rhsSum += modelVariables.z[*temp1];
                lhsSum += modelVariables.z[*temp2];
            }
        }
    }
    return rhsSum == lhsSum;
}

bool PortSimulation::cnstr_4_5(){
    int sum1 = 0;
    int sum2 = 0;
    int index = 0;
    foreach (AGV l, B){
        foreach (container c, containers.allC){
            std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(containers.c0,c,l,++index);
            std::unique_ptr<z_op> temp2 = std::make_unique<z_op>(c,containers.c0,l,++index);
            sum1 += modelVariables.z[*temp1];
            sum2 += modelVariables.z[*temp2];
        }
    }
    return sum1 == 1 && sum2 == 1;
}

bool PortSimulation::cnstr_6_7(){
    int sum6 = 0;
    int sum7 = 0;
    int index1 = 0;
    int index2 = 0;
    foreach(AGV l, B){
        foreach (container c1, containers.allC){
            if(c1.isLoading){
                {
                    std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(c1,containers.c0,l,++index1);
                    sum6 += modelVariables.z[*temp1];
                }
                foreach(container c2, containers.allC){
                    if(!c2.isLoading){
                        std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(c1,c2, l, ++index1);
                        sum6 += modelVariables.z[*temp1];
                    }
                }
            }
        }
        foreach (container c1, containers.allC){
            if(!c1.isLoading){
                {
                    std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(c1,containers.c0,l,++index1);
                    sum7 += modelVariables.z[*temp1];
                }
                foreach(container c2, containers.allC){
                    if(c2.isLoading){
                        std::unique_ptr<z_op> temp1 = std::make_unique<z_op>(c1,c2, l, ++index1);
                        sum7 += modelVariables.z[*temp1];
                    }
                }
            }
        }
    }
    return sum6 == 1 && sum7 == 1;
}

bool PortSimulation::FeasibilityChecker(){
    bool isSolFeas;


//////////////////////////////////////////////////
    return true;
}


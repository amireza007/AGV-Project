#include "PortSimulation.h"
#include <memory>
#include <QRandomGenerator>
#include <ctime>
#include <QSqlRecord>
#include <QSqlField>
#include <QString>
PortSimulation::PortSimulation(int _CNumber,int _AGVNumber): AGVNumber(_AGVNumber), CNumber(_CNumber){
    QCs[0] = QuayCrane(1,{0},{4,8,12});
    QCs[1] = QuayCrane(2,{0},{16,20,24});
    QCs[2] = QuayCrane(3,{0},{28,32});
    B.resize(AGVNumber);
    blocks[0] = Block({},1,{},5);
    blocks[1] = Block({},7,{},11);
    blocks[2] = Block({},13,{},17);
    blocks[3] = Block({},19,{},23);
    blocks[4] = Block({},25,{},29);
    blocks[5] = Block({},31,{},35);
    JobGenerator();
}

bool PortSimulation::BelongToSameBlock(container &c1, container &c2){
    for(int i = 0; i<6; i++){
        if(c1.verticalLocation>=blocks[i].AL_location && c1.verticalLocation<=blocks[i].AR_location && c2.verticalLocation >= blocks[i].AL_location && c2.verticalLocation <= blocks[i].AR_location )
            return true;
    }
    return false;
}

void PortSimulation::JobGenerator(){//this method should also initialize decision variables after the parameters of the model are built

    //important case not dealt with: what if two containers situated in one vertical path!
    int numOfContainers = CNumber;
    QRandomGenerator rand = QRandomGenerator(time(NULL));//the seed
    int NLoadC = rand.bounded(1,numOfContainers);
    qDebug() << NLoadC;
    int NDLoadC = numOfContainers - NLoadC;
    //start of job generation
    int LCIterator = 0;
    int DCIterator = 0;
    int randomQCPicker ;
    int randomBlockPicker ;
    int randomVertLoc;
    container randCont;
    int i = 0;
    QSqlRecord rec;
    //building containers and allC set
    rec.append(QSqlField("QC", QMetaType::fromType<QString>()));
    rec.append(QSqlField("indx", QMetaType::fromType<int>()));
    rec.append(QSqlField("verticalLoc", QMetaType::fromType<int>()));
    rec.append(QSqlField("Type", QMetaType::fromType<QString>()));
    while(i<numOfContainers)
    {
        if(++DCIterator <= NDLoadC){
            randomQCPicker = rand.bounded(0,3);
            QCs[randomQCPicker].m = randomQCPicker +1;

            rec.setValue(0,"m"+QString::number(QCs[randomQCPicker].m));
            QCs[randomQCPicker].jobs.append(QCs[randomQCPicker].jobs.last() + 1);
            rec.setValue(1,"i" + QString::number(QCs[randomQCPicker].jobs.last()) );
            if(randomQCPicker <= 1){ //QC[0] or QC[1] is selected, because these two have 3 vertical locations
                randomVertLoc = rand.bounded(0,3);
                randCont = container(randomQCPicker+1, QCs[randomQCPicker].jobs.last(),false,QCs[randomQCPicker].locations[randomVertLoc]);
                containers.allC.append(randCont);
                randCont.index = i;
            }else{ //QC[2] is selected
                randomVertLoc = rand.bounded(0,2);
                randCont = container(randomQCPicker+1, QCs[randomQCPicker].jobs.last(),false,QCs[randomQCPicker].locations[randomVertLoc]);
                randCont.index = i;
                containers.allC.append(randCont);
            }
            rec.setValue(2,QString::number(QCs[randomQCPicker].locations[randomVertLoc]));
            rec.setValue(3,"D");
            records.append(rec);
            rec.clearValues();
            i++;
        }
        if(++LCIterator <= NLoadC){
            //column for AL and AR should be added in the db
            randomBlockPicker = rand.bounded(0,6);

            randomQCPicker = rand.bounded(0,3);
            randomVertLoc = rand.bounded(blocks[randomBlockPicker].AL_location, blocks[randomBlockPicker].AR_location+1);//randomVertical suddenly becomes the actual member of XR, not an index variable!
            QCs[randomQCPicker].m = randomQCPicker + 1;
            rec.setValue(0,"m"+QString::number(QCs[randomQCPicker].m));

            QCs[randomQCPicker].jobs.append(QCs[randomQCPicker].jobs.last() + 1);
            rec.setValue(1,"i" + QString::number(QCs[randomQCPicker].jobs.last()) );
            randCont = container(randomQCPicker + 1, QCs[randomQCPicker].jobs.last(),true,randomVertLoc);
            randCont.index = i;
            containers.allC.append(randCont);
            rec.setValue(2,QString::number(randomVertLoc));
            rec.setValue(3,"L");
            records.append(rec);
            rec.clearValues();
            i++;
        }
    }

    //building psi_1, psi_2 and o_{(m,i)}

    //psi_1 determines m1,i1,m1,i3 both being DLoadCont
    //For this: iterate over all containers, compare each two of them and check: 1. they belong to the same QC 2. compare their vertical loc is
    for(auto &c1: containers.allC){ if(!c1.isLoading)
        {
            for(auto &c2: containers.allC){
                if(!c2.isLoading){
                    if(std::get<0>(c1.c) == std::get<0>(c2.c)){
                        if(std::get<1>(c1.c) < std::get<1>(c2.c)){
                            psi1.append({c1,c2});
                        }else if(std::get<1>(c1.c) > std::get<1>(c2.c)){
                            psi1.append({c2,c1});
                        }
                    }
                }
            }
        }
    }
    //psi_2 determines two container belonging to the same block, be executed according to their location!
    for(auto& c1: containers.allC){
        if(c1.isLoading){
            for(auto& c2: containers.allC){
                if(c2.isLoading){
                    if (BelongToSameBlock(c1,c2))
                        if(c1.verticalLocation < c2.verticalLocation){
                            psi1.append({c1,c2});
                        }else if(c1.verticalLocation > c2.verticalLocation){
                            psi1.append({c2,c1});
                        }
                }
            }
        }
    }
    //o_(m,i) is just cont.verticalLoc!
    for(const auto &c: containers.allC){
        O_Container.append({{c,c.verticalLocation}});
    }
    //////////////////////////////////////////////////////////

    /// building the database
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

    return true;
}


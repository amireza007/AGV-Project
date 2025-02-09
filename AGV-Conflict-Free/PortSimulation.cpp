#include "PortSimulation.h"
#include <memory>
#include <QRandomGenerator>
PortSimulation::PortSimulation(int _CNumber,int _AGVNumber) :CNumber(_CNumber), AGVNumber(_AGVNumber) {
    QCs[0] = QuayCrane(1,{},{4,8,12});
    QCs[1] = QuayCrane(2,{},{16,20,24});
    QCs[3] = QuayCrane(3,{},{28,32});
    JobGenerator();
}

void PortSimulation::JobGenerator(){//this method should also initialize decision variables after the parameters of the model are built

    int numOfAGVs = 4;

    int numOfContainers = 10;
    QRandomGenerator rand = QRandomGenerator();
    int NLoadC = (rand.generate() % 10)+ 1;
    int NDLoadC = numOfContainers - NLoadC;
    // // Generate Jobs and Schedule (Static fashion )
    // int i,i1,i2,r;
    // if( b == false)
    //     for(i=1; i<=StrToInt(Edit1->Text);i++) //number of Total container jobs specified
    //     {
    //         r = 3 + random(2); // 4 if we like four cases // ditributing unloading and loading jobs randomly
    //             // 3 because we like to have only Yard to berth and vice versa
    //         switch(r)
    //         {
    //         case 3: // Yard to Berth
    //             // if(MCFAlgorithmForm->CheckBox1->Checked )
    //             //    srand(2); // 30/04/04
    //             // else
    //             //   randomize();
    //             i1 = 1+ random(StrToInt(MCFAlgorithmForm->Edit3->Text)); //number of blocks
    //             if (MCFAlgorithmForm->RadioButton8->Checked == true ) //single loaded QC
    //                 i2 = 1;
    //             else if (MCFAlgorithmForm->RadioButton9->Checked == true )//multiple loaded QCs
    //                 i2 = 1+ random(StrToInt(MCFAlgorithmForm->Edit12->Text)); number of w/p (QCs) in dynamic fashion
    //             else
    //             {
    //                 i2 = Next_Quay_Crane;
    //                 if(++Next_Quay_Crane > Number_Of_Cranes ) Next_Quay_Crane = 1;
    //             }
    //             BlockStrS = "Block "; BlockStrS = BlockStrS + i1;
    //             BlockStrD = "W/P "; BlockStrD = BlockStrD + i2;
    //             break;
    //         case 4: // Berth to Yard
    //             //   if(MCFAlgorithmForm->CheckBox1->Checked )
    //             //      srand(3); // 30/04/04
    //             //   else
    //             //      randomize();
    //             if (MCFAlgorithmForm->RadioButton8->Checked == true )
    //                 i2 = 1;
    //             else if (MCFAlgorithmForm->RadioButton9->Checked == true ) //if multiple cranes (random) in static is chosen
    //                 i2 = 1+ random(StrToInt(->Edit12->Text));// number of w/ps (QCs) in dynamic??
    //             elseMCFAlgorithmForm
    //             {
    //                 i2 = Next_Quay_Crane;
    //                 if(++Next_Quay_Crane > Number_Of_Cranes ) Next_Quay_Crane = 1;
    //             }
    //             i1 = 1+ random(StrToInt(MCFAlgorithmForm->Edit3->Text)); //number of blocks
    //             BlockStrS = "W/P "; BlockStrS = BlockStrS + i2;
    //             BlockStrD = "Block "; BlockStrD = BlockStrD + i1;
    //             break;
    //         }
    //         PortContainerForm->Table1->Append();

    //         AnsiString ContainerIDStrS = "C-BS-";
    //         ContainerIDStrS = ContainerIDStrS + IntToStr(i);

    //         PortContainerForm->Table1->FieldValues["ContainerID"]= ContainerIDStrS;
    //         PortContainerForm->Table1->FieldValues["Portname"]   = ListBox1->Items->Strings[ListBox1->ItemIndex];

    //         PortContainerForm->Table1->FieldValues["SourcePoint"]= BlockStrS;
    //         PortContainerForm->Table1->FieldValues["DestPoint"]  = BlockStrD;

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


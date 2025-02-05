#include "PortSimulation.h"

PortSimulation::PortSimulation(int _CNumber,int _AGVNumber) :CNumber(_CNumber), AGVNumber(_AGVNumber) {
    JobGenerator();
}

void PortSimulation::JobGenerator(){//this method should also initialize decision variables after the parameters of the model are built


    // // Generate Jobs and Schedule (Static fashion )
    // int i,i1,i2,r;
    // AnsiString BlockStrS, BlockStrD;

    // TLocateOptions Opts;
    // AnsiString DistanceStr;
    // Opts.Clear();
    // Variant locvalues[3];


    // if(ListBox1->ItemIndex < 0) return;

    // static int Next_Quay_Crane = 1;
    // if (DynamicSchedulingStarted) Next_Quay_Crane = 1;

    // long int BaseTime = TimeValueInSecond + GlobalInitialTimeQuayCrane;

    // int Quay_Crane_Time_Window = StrToInt(MCFAlgorithmForm->Edit26->Text);
    // int Number_Of_Cranes       = StrToInt(MCFAlgorithmForm->Edit6->Text);
    // int Number_Of_Vehicles     = StrToInt(MCFAlgorithmForm->Edit4->Text);

    // for(int CN=1;CN<=Number_Of_Cranes;CN++)
    // {
    //     Crane_Buff[CN-1].Number_Of_Done_Jobs = 0;// reset button
    //     Crane_Buff[CN-1].Next_Generation_Time= StrToInt(Edit23->Text);
    //     Crane_Buff[CN-1].Last_Completed_Time = StrToInt(Edit23->Text);
    //     Crane_Buff[CN-1].Last_Completed_Temp = StrToInt(Edit23->Text);
    // }

    // for(int VN=1;VN<=Number_Of_Vehicles;VN++)
    // {
    //     Vehicle_Buff[VN-1].Number_Of_Jobs      = 0;
    //     Vehicle_Buff[VN-1].Number_Of_Done_Jobs = 0;

    //     Vehicle_Buff[VN-1].Last_Completed_Time = 0;
    // }

    // locvalues[0] = ListBox1->Items->Strings[ListBox1->ItemIndex];
    // //If we have generated some jobs for some ports, why to generate them again?? :))
    // bool b = PortContainerForm->Table1->Locate("Portname", VarArrayOf(locvalues, 0), Opts);

    // Label25->Color = clGray ;
    // Label25->Caption = "Generating Jobs...";// Static Fashion
    // GroupBox15->Refresh();

    // if(MCFAlgorithmForm->CheckBox1->Checked )
    //     srand(1); // 30/04/04
    // else
    //     randomize();
    /////////////////////////////////////////////////////////////////////////////////////////////
    //START OF JOB GENERATION
    // if( b == false)
    //     for(i=1; i<=StrToInt(Edit1->Text);i++) //number of Total container jobs specified
    //     {
    //         ProgressBar1->Position = 100*i/StrToInt(Edit1->Text);
    //         r = 3 + random(2); // 4 if we like four cases
    //             // 3 because we like to have only Yard to berth and vice versa
    //         switch(r)
    //         {
    //         case 3: // Yard to Berth
    //             // if(MCFAlgorithmForm->CheckBox1->Checked )
    //             //    srand(2); // 30/04/04
    //             // else
    //             //   randomize();
    //             i1 = 1+ random(StrToInt(MCFAlgorithmForm->Edit3->Text));
    //             if (MCFAlgorithmForm->RadioButton8->Checked == true )
    //                 i2 = 1;
    //             else if (MCFAlgorithmForm->RadioButton9->Checked == true )
    //                 i2 = 1+ random(StrToInt(MCFAlgorithmForm->Edit12->Text));
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
    //             else if (MCFAlgorithmForm->RadioButton9->Checked == true ) //if multiple cranes (randon) in static is chosen
    //                 i2 = 1+ random(StrToInt(MCFAlgorithmForm->Edit12->Text));// number of w/ps (QCs) in dynamic??
    //             else
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

#include "DecisionVariables.h"

ModelVariables::ModelVariables(){
    container temp;
    // const AGV l;
    // conststd::tuple<container,container,AGV> t2(temp,temp,l);
    // z = {{temp, 0}};
}

bool cmp1::operator()(const std::tuple<W,int>& t1, const std::tuple<W,int>& t2)
{
    W temp1 = std::get<0>(t1);
    W temp2 = std::get<0>(t2);
    int xr1 = std::get<1>(t1);
    int xr2 = std::get<1>(t1);
    if((compareTwoW(temp1, temp2)))
        return true;
    else{
        if (xr1 < xr2)
            return true;
    }
    return false;
}

static bool compareTwoW(W& w1, W& w2){
    container temp1 = std::get<0>(w1);
    container temp2 = std::get<0>(w2);
    if(std::get<0>(temp1.c) < std::get<0>(temp2.c)){
        return true;
    }
    else{
        if(std::get<1>(temp1.c) < std::get<1>(temp2.c)){
            return true;
        }
        else{
            if (static_cast<int>(std::get<1>(w2)) == static_cast<int>(std::get<1>(w1)) + 1)
                return true;
        }
    }
    return false;
}

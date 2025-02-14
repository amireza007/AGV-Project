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
    QVector<W> v1 = {temp1};
    QVector<W> v2 = {temp2};

    if((compareWs(v1, v2)))
        return true;
    else{
        if (xr1 < xr2)
            return true;
    }
    return false;
}

bool cmp2::operator()(const std::tuple<W,W>& t1, const std::tuple<W,W>& t2){
    QVector<W> v1 = {std::get<0>(t1), std::get<1>(t1)};
    QVector<W> v2 = {std::get<0>(t2), std::get<1>(t2)};
    return compareWs(v1,v2);
}

bool cmp3::operator ()(const W& w1, const W& w2){
    QVector<W> v1 = {w1};
    QVector<W> v2 = {w2};
    return compareWs(v1,v2);
}

static bool compareWs(QVector<W> v1, QVector<W> v2){
    //we assume size of v1 and v2 are equal

    for(int i = 0; i<v1.size(); i++){
        W w1 = v1[i];
        W w2 = v2[i];
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
    }
    return false;
}

bool cmp4::operator ()(const container& c1, const container& c2){
    if(std::get<0>(c1.c) < std::get<0>(c2.c)){
        return true;
    }else{
        if(std::get<1>(c1.c) < std::get<1>(c2.c)){
            return true;
        }
    }
    return false;

}

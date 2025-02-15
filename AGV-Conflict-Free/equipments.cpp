#include "equipments.h"

bool cmp5::operator ()(const container& c1, const container& c2){
    if(std::get<0>(c1.c) < std::get<0>(c2.c)){
        return true;
    }else{
        if(std::get<1>(c1.c) < std::get<1>(c2.c)){
            return true;
        }
    }
    return false;

}

#include "FunctionList.h"


void FunctionList::InitializeBlankFunction()
{
    Function Temp;
    Functions.push_back(Temp);
}

Function * FunctionList::GetLastFunction()
{
    return &Functions.back();
}

Function * FunctionList::GetFirstFunction()
{
    return &Functions.front();
}

Function * FunctionList::GetFirstFunctionNotOfPassMode(const PASS_MODE InPassMode)
{
    bool Found = false;
    unsigned int Index = 0;
    typename list<Function>::iterator it = Functions.begin();
    while(Index < Functions.size() && Found == false)
    {
        if((*it).LatestPassMode != InPassMode)
        {
            Found = true;
        }
        else
        {
            Index = Index + 1;
            it++;
        }
    }
    return &(*it);
}
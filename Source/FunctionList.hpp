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
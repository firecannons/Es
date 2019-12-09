#include "BaseType.h"
#include <iostream>

void BaseType::InitializeBlankCompiledTemplate()
{
    if(CompiledTemplates.size() > 0)
    {
        cout << &CompiledTemplates[0] << endl;
    }
    CompiledTemplate Temp;
    CompiledTemplates.push_back(Temp);
    if(CompiledTemplates.size() > 0)
    {
        cout << &CompiledTemplates[0] << endl;
    }
}

CompiledTemplate * BaseType::GetLastCompiledTemplate()
{
    return &CompiledTemplates[CompiledTemplates.size() - 1];
}

CompiledTemplate * BaseType::GetFirstCompiledTemplate()
{
    CompiledTemplate * Output;
    if(CompiledTemplates.size() > 0)
    {
        Output = &CompiledTemplates[0];
    }
    else
    {
        Output = NULL;
    }
    return Output;
}
#include "BaseType.h"
#include <iostream>

void BaseType::InitializeBlankCompiledTemplate()
{
    CompiledTemplate Temp;
    CompiledTemplates.push_back(Temp);
}

CompiledTemplate * BaseType::GetLastCompiledTemplate()
{
    return &CompiledTemplates.back();
}

CompiledTemplate * BaseType::GetFirstCompiledTemplate()
{
    return &CompiledTemplates.front();
}
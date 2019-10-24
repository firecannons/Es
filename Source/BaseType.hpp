#include "BaseType.h"

void BaseType::InitializeBlankCompiledTemplate()
{
    CompiledTemplate Temp;
    CompiledTemplates.push_back(Temp);
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
#include "Scope.h"

Scope::Scope()
{
    Offset = 0;
}

bool Scope::IsControlStructureScope()
{
    bool Output = false;
    if(Origin == SCOPE_ORIGIN::IF || Origin == SCOPE_ORIGIN::REPEAT)
    {
        Output = true;
    }
    return Output;
}

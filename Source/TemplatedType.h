
#ifndef TEMPLATEDTYPE_H
#define TEMPLATEDTYPE_H

#include "BaseType.h"
#include "CompiledTemplate.h"

class TemplatedType
{
    
public:
    BaseType * Type;
    CompiledTemplate * Templates;
};

#include "TemplatedType.hpp"
#endif

#include "CompiledTemplate.h"

CompiledTemplate::CompiledTemplate()
{
    Size = 0;
    HasSizeBeenCalculated = false;
    IsNewCompiledTemplate = true;
    MostRecentPass = PASS_MODE::CLASS_SKIM;
}

// Forward-declaring classes to avoid circular dependency problems.

class BaseType;
class Object;
class Function;
class TemplatedType;
class Lexer;
class Compiler;
class Parser;
class Scope;
class CompiledTemplate;
class FunctionList;

#include <string>
#include "GlobalFunctions.h"
#include "Compiler.h"

using namespace std;

const unsigned CORRECT_NUMBER_INPUT_PARAMS = 3;

int main(int argc, char *argv[])
{
    if(argc != CORRECT_NUMBER_INPUT_PARAMS)
    {
        PrintError("Wrong number of input parameters.");
    }
    string SourceProgram = string(argv[1]);
    string OutputProgram = string(argv[2]);
    
    Compiler FirstCompiler;
    FirstCompiler.Compile(SourceProgram, OutputProgram);
}

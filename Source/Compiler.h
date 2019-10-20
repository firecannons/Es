
#ifndef COMPILER_H
#define COMPILER_H

#include "Keywords.h"
#include "GlobalFunctions.h"
#include "Lexer.h"
#include "Token.h"
#include <string>
#include <fstream>
#include <sstream>
#include <vector>
using namespace std;

class Compiler
{
    
public:
    void Compile(const string & SourceFile, const string & OutputFile);

    string CompileToAsm(const string & SourceFile);
    
    string ReadInputFile(const string & SourceName);
    
    string CompileToOutputText(const string & InputCode, const string & SourceFile);
    
    void WriteToOutputFile(const string & OutputCode, const string & OutputFile);
};

#include "Parser.h"

#include "Compiler.hpp"
#endif

#include "Compiler.h"


void Compiler::Compile(const string & SourceFile, const string & OutputFile)
{
    string OutputText = CompileToAsm(SourceFile);
    WriteToOutputFile(OutputText, OutputFile);
}

string Compiler::CompileToAsm(const string & SourceFile)
{
    string InputText = ReadInputFile(SourceFile);
    string OutputText = CompileToOutputText(InputText, SourceFile);
    return OutputText;
}

string Compiler::ReadInputFile(const string & SourceProgram)
{
    ifstream In;
    In.open(SourceProgram);

    stringstream StringStream;
    StringStream << In.rdbuf();
    string SourceCode = StringStream.str();
    In.close();
    return SourceCode;
}


string Compiler::CompileToOutputText(const string & InputCode, const string & SourceFile)
{
    Lexer FirstLex;
    vector<Token> Tokens = FirstLex.Lex(InputCode);
    Parser FirstParser;
    string AsmString = FirstParser.Parse(Tokens, SourceFile);
    return AsmString;
}


void Compiler::WriteToOutputFile(const string & OutputCode, const string & OutputFile)
{
    std::ofstream out(OutputFile + ".asm");
    out << OutputCode;
    out.close();
}

#include "Keywords.h"

Keywords::Keywords()
{

    ReservedWords.insert(pair<string,string>(string("CLASS"), string("class")));
    ReservedWords.insert(pair<string,string>(string("ACTION"), string("action")));
    ReservedWords.insert(pair<string,string>(string("USING"), string("using")));
    ReservedWords.insert(pair<string,string>(string("DOT"), string(".")));
    ReservedWords.insert(pair<string,string>(string("BACK_SLASH"), string("\\")));
    ReservedWords.insert(pair<string,string>(string("FORWARD_SLASH"), string("/")));
    ReservedWords.insert(pair<string,string>(string("NEW_LINE"), string("\n")));
    ReservedWords.insert(pair<string,string>(string("LESS_THAN"), string("<")));
    ReservedWords.insert(pair<string,string>(string("GREATER_THAN"), string(">")));
    ReservedWords.insert(pair<string,string>(string("COMMA"), string(",")));
    ReservedWords.insert(pair<string,string>(string("SIZE"), string("size")));
    ReservedWords.insert(pair<string,string>(string("RETURNS"), string("returns")));
    ReservedWords.insert(pair<string,string>(string("RETURN"), string("return")));
    ReservedWords.insert(pair<string,string>(string("LPAREN"), string("(")));
    ReservedWords.insert(pair<string,string>(string("RPAREN"), string(")")));
    ReservedWords.insert(pair<string,string>(string("ASM"), string("asm")));
    ReservedWords.insert(pair<string,string>(string("END"), string("end")));
    ReservedWords.insert(pair<string,string>(string("EQUALS"), string("=")));
    
    ShortOperators.emplace(ReservedWords["LESS_THAN"]);
    ShortOperators.emplace(ReservedWords["GREATER_THAN"]);
    ShortOperators.emplace(ReservedWords["EQUALS"]);
    
    OverloadableOperators = ShortOperators;
    OverloadableOperators.emplace(string("<="));
    OverloadableOperators.emplace(string(">="));
    OverloadableOperators.emplace(ReservedWords["LEFT_BRACKET"]);
    OverloadableOperators.emplace(ReservedWords["RIGHT_BRACKET"]);
    OverloadableOperators.emplace(string("=="));
    OverloadableOperators.emplace(string("+"));
    OverloadableOperators.emplace(string("-"));
    OverloadableOperators.emplace(string("*"));
    OverloadableOperators.emplace(string("/"));
    OverloadableOperators.emplace(string("!="));

    AfterDeclarationOperators.emplace(ReservedWords["EQUALS"]);

    AllOperators = OverloadableOperators;
    AllOperators.emplace(string("//"));
    AllOperators.emplace(ReservedWords["LPAREN"]);
    AllOperators.emplace(ReservedWords["RPAREN"]);
    AllOperators.emplace(string(":"));
}
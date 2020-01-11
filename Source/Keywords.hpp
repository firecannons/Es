#include "Keywords.h"

Keywords::Keywords()
{
    
    AsmLinkWords.insert(pair<string,string>(string("GET_SIZE_OF"), string("GetSize")));
    AsmLinkWords.insert(pair<string,string>(string("GET_ACTION"), string("GetAction")));
    
    ReservedWords = AsmLinkWords;
    ReservedWords.insert(pair<string,string>(string("CLASS"), string("class")));
    ReservedWords.insert(pair<string,string>(string("ACTION"), string("action")));
    ReservedWords.insert(pair<string,string>(string("USING"), string("using")));
    ReservedWords.insert(pair<string,string>(string("DOT"), string(".")));
    ReservedWords.insert(pair<string,string>(string("BACK_SLASH"), string("\\")));
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
    ReservedWords.insert(pair<string,string>(string("COLON"), string(":")));
    ReservedWords.insert(pair<string,string>(string("STAR"), string("*")));
    ReservedWords.insert(pair<string,string>(string("SLASH"), string("/")));
    ReservedWords.insert(pair<string,string>(string("PLUS"), string("+")));
    ReservedWords.insert(pair<string,string>(string("MINUS"), string("-")));
    ReservedWords.insert(pair<string,string>(string("LESS_OR_EQUAL"), string("<=")));
    ReservedWords.insert(pair<string,string>(string("GREATER_OR_EQUAL"), string(">=")));
    ReservedWords.insert(pair<string,string>(string("IS_EQUAL"), string("==")));
    ReservedWords.insert(pair<string,string>(string("NOT_EQUAL"), string("!=")));
    ReservedWords.insert(pair<string,string>(string("UNDER_SCORE"), string("_")));
    ReservedWords.insert(pair<string,string>(string("ME"), string("Me")));
    ReservedWords.insert(pair<string,string>(string("REPEAT"), string("repeat")));
    ReservedWords.insert(pair<string,string>(string("IF"), string("if")));
    ReservedWords.insert(pair<string,string>(string("EXCLAMATION"), string("!")));
    ReservedWords.insert(pair<string,string>(string("MULTI_LINE_COMMENT_BEGIN"), string("/*")));
    ReservedWords.insert(pair<string,string>(string("MULTI_LINE_COMMENT_END"), string("*/")));
    ReservedWords.insert(pair<string,string>(string("REPEAT"), string("repeat")));
    ReservedWords.insert(pair<string,string>(string("WHILE"), string("while")));
    ReservedWords.insert(pair<string,string>(string("UNTIL"), string("until")));
    ReservedWords.insert(pair<string,string>(string("IF"), string("if")));
    ReservedWords.insert(pair<string,string>(string("ELSE_IF"), string("elseif")));
    ReservedWords.insert(pair<string,string>(string("ELSE"), string("else")));
    ReservedWords.insert(pair<string,string>(string("REFERENCE"), string("reference")));
    ReservedWords.insert(pair<string,string>(string("CONSTRUCTOR"), string("Constructor")));
    ReservedWords.insert(pair<string,string>(string("DESTRUCTOR"), string("Destructor")));
    ReservedWords.insert(pair<string,string>(string("SOURCE"), string("Source")));
    
    ShortOperators.emplace(ReservedWords["LESS_THAN"]);
    ShortOperators.emplace(ReservedWords["GREATER_THAN"]);
    ShortOperators.emplace(ReservedWords["EQUALS"]);
    ShortOperators.emplace(ReservedWords["SLASH"]);
    ShortOperators.emplace(ReservedWords["EXCLAMATION"]);
    
    BinaryOperators = ShortOperators;
    BinaryOperators.emplace(ReservedWords["LESS_OR_EQUAL"]);
    BinaryOperators.emplace(ReservedWords["GREATER_OR_EQUAL"]);
    BinaryOperators.emplace(ReservedWords["LEFT_BRACKET"]);
    BinaryOperators.emplace(ReservedWords["RIGHT_BRACKET"]);
    BinaryOperators.emplace(ReservedWords["IS_EQUAL"]);
    BinaryOperators.emplace(ReservedWords["NOT_EQUAL"]);
    BinaryOperators.emplace(ReservedWords["PLUS"]);
    BinaryOperators.emplace(ReservedWords["MINUS"]);
    BinaryOperators.emplace(ReservedWords["STAR"]);
    
    UnaryOperators.emplace(ReservedWords["MINUS"]);
    
    OverloadableOperators = BinaryOperators;
    OverloadableOperators.insert(UnaryOperators.begin(), UnaryOperators.end());

    AfterDeclarationOperators.emplace(ReservedWords["EQUALS"]);
    
    ReducibleOperators = OverloadableOperators;
    ReducibleOperators.emplace(ReservedWords["LPAREN"]);
    ReducibleOperators.emplace(ReservedWords["RPAREN"]);
    ReducibleOperators.emplace(ReservedWords["COLON"]);
    ReducibleOperators.emplace(ReservedWords["COMMA"]);

    AllOperators = ReducibleOperators;
    AllOperators.emplace(string("//"));
    AllOperators.emplace(ReservedWords["MULTI_LINE_COMMENT_BEGIN"]);
    AllOperators.emplace(ReservedWords["MULTI_LINE_COMMENT_END"]);

    ScopeCreateKeywords.emplace(ReservedWords["ACTION"]);
    ScopeCreateKeywords.emplace(ReservedWords["CLASS"]);
    ScopeCreateKeywords.emplace(ReservedWords["REPEAT"]);
    ScopeCreateKeywords.emplace(ReservedWords["IF"]);
}

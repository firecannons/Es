#include <stdio.h>
#include <string>

struct String
{
	char Buffer [ 50 ] ;
	int Length ;
} ;

class TenStrings
{
public:
	std::string Str1 ;
	std::string Str2 ;
	std::string Str3 ;
	std::string Str4 ;
	std::string Str5 ;
	std::string Str6 ;
	std::string Str7 ;
	std::string Str8 ;
	std::string Str9 ;
	std::string Str10 ;
} ;

int  main()
{
	int my1 = 1 ;
	int my2 = 2 ;
	int my3 = 2 ;
	int my4 = 2 ;
	int my5 = 2 ;
	scanf("%d", &my5);
	if (my5 == 5)
	{
		my4 = 4 ;
	}
	else
	{
		my3 = 3 ;
	}
	
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	
	struct String Text1 ;
	
	Text1 . Length = 19 ;
	Text1 . Buffer [ 0 ] = 'a' ;
	Text1 . Buffer [ 1 ] = 'b' ;
	Text1 . Buffer [ 2 ] = '\0' ;
	Text1 . Buffer [ 49 ] = '\0' ;
	printf ( "%d" , Text1 . Length ) ;
	printf ( "%s" , Text1 . Buffer ) ;
	
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	
	std::string cpp_text ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	cpp_text = "hello world" ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	printf ( "%s" , cpp_text.c_str() ) ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	TenStrings thestrings ;
	printf ( "%s" , thestrings . Str1 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str2 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str3 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str4 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str5 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str6 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str7 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str8 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str9 . c_str ( ) ) ;
	printf ( "%s" , thestrings . Str10 . c_str ( ) ) ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	
	
	return 0;
}
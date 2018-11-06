#include <stdio.h>

const char * MY_STR = "ASM IS HARD" ;

struct String
{
	char Buffer [ 50 ] ;
	int Length ;
} ;

int MyFunction ( char c1 , char c2 , char c3 , char c4 , char c5 , char c6 , char c7 , char c8
, char c9 , char c10 , char c11 , char c12 , char c13 , char c14 , char c15 , char c16 , char c17 ,
char c18 )
{
	int my_int = 0 ;
	scanf("%d", &my_int);
	printf ( "%d %c %c %c %c %c" , my_int , c1 , c2 , c3 , c4 , c5 ) ;
	return my_int ;
}

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
	
	int my_int = MyFunction ( '1' , '1' , '1' , '1' , '1' , '1' , '1' , '1' , '1' , '1' , '1'
, '1' , '1' , '1' , '1' , '1' , '1' , '1' ) ;
	printf ( "%d" , my_int ) ;
	
	printf ( "%s" , MY_STR ) ;
	
	return 0;
}

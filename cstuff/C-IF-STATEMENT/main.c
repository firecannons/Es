#include <stdio.h>

const char * MY_STR = "ASM IS HARD" ;

struct String
{
	char Buffer [ 50 ] ;
	int Length ;
} ;

int SecondFunction ( )
{
	int i = 0 ;
	scanf ( "%d" , &i ) ;
	printf ( "%d" , i ) ;
	
	if ( i == 157 )
	{
		printf ( "%d" , i ) ;
	}
	else
	{
		printf ( "no" ) ;
	}
	
	return i ;
}

int  main()
{
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	SecondFunction ( ) ;
	asm (";\n;\n;\n;\n;\n;\n;\n;\n;\n;\n;");
	
	return 0;
}

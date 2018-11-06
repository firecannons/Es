#include <stdio.h>

void Prep ( char array [ ] )
{
	array [ 0 ] = 'a' ;
	array [ 1 ] = 'b' ;
	array [ 2 ] = 'c' ;
	array [ 3 ] = '\0' ;
	char SuperArray [ 100000 ] = {0} ;
	printf ( "%s" , SuperArray ) ;
}

int main ( )
{
	char array1 [ 50 ] = {0} ;
	char array2 [ 50 ] = {0} ;
	char array3 [ 50 ] = {0} ;
	char mychar = '\0' ;
	scanf ( "%c" , &mychar ) ;
	printf ( "%c" , mychar ) ;
	
	if ( mychar == '1' )
	{
		char SuperArray [ 1000 ] = {0} ;
		printf ( "%s" , SuperArray ) ;
	}
	
	Prep ( array1 ) ;
	printf ( "%s\n" , array1 ) ;
	printf ( "%s\n" , array2 ) ;
	printf ( "%s\n" , array3 ) ;
	
	return 0;
}
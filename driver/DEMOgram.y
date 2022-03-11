%{ 
/* Copyright 2016, Keith D. Cooper & Linda Torczon
 * 
 * Written at Rice University, Houston, Texas as part
 * of the instructional materials for COMP 506.
 *
 * The University may have some rights in this work.
 *
 */

#define YYERROR_VERBOSE

#include <stdio.h>
#include "demo.h"

int yylineno;
char *yytext;
void yyerror( char const *);

%}

/* Bison declarations */
%start  Grammar
%%

 /* Grammar rules  */
Grammar:  {return 1;} 	
;

%%


/* Epilogue */


void yyerror(s)
   const char *s;
{
	
}


%option noyywrap
%{

 /* DEMO parser (parser for the language "DEMO")
  * Copyright 2015, Keith D. Cooper 
  * 
  * Written at Rice University, Houston, Texas.
  * The University may have some rights in this work.
  *
  */
 
#ifdef FLEX_SCANNER
extern int yylineno;
#define YYINCR(n) yylineno += n
#else
#define YYINCR(n)
#endif

#include "tokens.h"
#include "strings.h"
#include "demo.h"
#include<stdio.h> 

int CTRL_M = 0;

%}
%%
"and" { printf("AND\n"); return AND; }


<<EOF>>                       { printf("TOKEN EOF\n");(void) strcpy(TokenString,"EOF");  return ENDOFFILE; }
%%

int main (int argc, char *argv[])
{       
    int count;
    char c;
    FILE *fptr;

    printf ("This program was called with \"%s\".\n",argv[0]);
    
    if (argc > 1)
    {
        for (count = 1; count < argc; count++)
        {
            printf("argv[%d] = %s\n", count, argv[count]);
        }
    }
    else
    {
        printf("The command had no other arguments.\n");
    }
    
    yyin = fopen(argv[1], "r" );
    if (yyin == NULL)
    {
        printf("Cannot open file \n");
        exit(0);
    }
    
    // Read contents from file
    c = fgetc(yyin);
    char inputS[60000];
    inputS[0] = '\0';
    strncat(inputS, &c, 1);
    while (c != EOF)
    {
        printf ("%c", c);
        c = fgetc(yyin);
        strncat(inputS, &c, 1); 
    }
    size_t input_len = strlen(inputS);
    char rest[input_len];
    strcpy(rest, inputS);
    rest[input_len-1] = '\0';

    while(rest)
    {
	yy_scan_string(rest);
	yylex();
	if(strcmp(TokenString,"EOF") == 0)
	{
	   break;
	}
        strcpy(rest, strstr(rest, TokenString));
	size_t token_len = strlen(TokenString);
	size_t text_len = strlen(rest);
	char sub_rest[text_len-token_len+1];
	memcpy(sub_rest, &rest[token_len], text_len-token_len);
	sub_rest[text_len-token_len] = '\0';
	strcpy(rest,sub_rest);
    }
    printf("succeeded \n");
}








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
"and" {
	printf("AND\n");
	return AND;
}

"by" {
	printf("BY\n");
	return BY;
}

"char" {
	printf("CHAR\n");
	return CHAR;
}

"else" {
	printf("ELSE\n");
	return ELSE;
}

"for" {
	printf("FOR\n");
	return FOR;
}

"if" {
	printf("IF\n");
	return IF;
}

"int" {
	printf("INT\n");
	return INT;
}

"not" {
	printf("NOT\n");
	return NOT;
}

"or" {
	printf("OR\n");
	return OR;
}

"procedure" {
	printf("PROCEDURE\n");
	return PROCEDURE;
}

"read" {
	printf("READ\n");
	return READ;
}

"then" {
	printf("THEN\n");
	return THEN;
}

"to" {
	printf("TO\n");
	return TO;
}

"while" {
	printf("WHILE\n");
	return WHILE;
}

"write" {
	printf("WRITE\n");
	return WRITE;
}

"+" {
	printf("%c\n", '+');
	return '+';
}

"-"	{
	printf("%c\n", '-');
	return '-';
}

"*" {
	printf("%c\n", '*');
	return '*';
}

"/" {
	printf("%c\n", '/');
	
	return '/';
}
"<" {
	printf("LT\n");
	return LT;
}

"<=" {
	printf("LE\n");
	return LE;
}

"==" {
	printf("EQ\n");
	return EQ;
}

"!=" {
	printf("NE\n");
	return NE;
}

">" {
	printf("GT\n");
	return GT;
}

">=" {
	printf("GE\n");
	return GE;
}

":" {
	printf("%c\n", ':');
	return ':';
}

";"	{
	printf("%c\n", ';');
	return ';';
}

"," {
	printf("%c\n", ',');
	return ',';
}

"=" {
	printf("%c\n", '=');
	return '=';
}

"{" {
	printf("%c\n", '{');
	return '{';
}

"}" {
	printf("%c\n", '}');
	return '}';
}

"[" {
	printf("%c\n", '[');
	return '[';
}

"]" {
	printf("%c\n", ']');
	return ']';
}

"(" {
	printf("%c\n", '(');
	return '(';
}

")" {
	printf("%c\n", ')');
	return ')';
}

[A-Za-z][A-Za-z0-9]* {
	printf("NAME\n");
	return NAME;
}

[0-9]+ {
	printf("NUMBER\n");
	return NUMBER;
}

'([^\n]|\\.)' {
	printf("CHARCONST\n");	
	return CHARCONST;
}

"//".* {
	printf("//");
}

[ \t]* {
	printf("BLANK\n");
}

/* add the [\n] to the rule.m Although it is not mentioned in files, it is necessary to be included. */
[\n] {
	printf("LINE++\n");
	yylineno++;
}

<<EOF>>                       { printf("TOKEN EOF\n");(void) strcpy(TokenString,"EOF");  return ENDOFFILE; }
%%
.
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








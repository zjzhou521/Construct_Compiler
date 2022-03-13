%option noyywrap
%{

 /* DEMO scanner
  * 
  * Written at Rice University, Houston, Texas.
  *
  */
 
 /* definitions */

#ifdef FLEX_SCANNER
extern int yylineno;
#define YYINCR(n) yylineno += n
#else
#define YYINCR(n)
#endif

#include "tokens.h"
#include "strings.h"
#include "demo.h"


int CTRL_M = 0;

%}
AND "and"
BY "by"
CHAR "char"
ELSE "else"
FOR "for"
IF "if"
INT "int"
NOT "not"
OR "or"
PROCEDURE "procedure"
READ "read"
THEN "then"
TO "to"
WHILE "while"
WRITE "write"

LT "<"
LE "<="
EQ "=="
NE "!="
GT ">"
GE ">="

NAME [A-Za-z][A-Za-z0-9]*
NUMBER [0-9]+
CHARCONST '([^\n]|\\.)'

%%
 /* rules  */
{AND} {
	printf("AND\n");
	return AND;
}

{BY} {
	printf("BY\n");
	return BY;
}

{CHAR} {
	printf("CHAR\n");
	return CHAR;
}

{ELSE} {
	printf("ELSE\n");
	return ELSE;
}

{FOR} {
	printf("FOR\n");
	return FOR;
}

{IF} {
	printf("IF\n");
	return IF;
}

{INT} {
	printf("INT\n");
	return INT;
}

{NOT} {
	printf("NOT\n");
	return NOT;
}

{OR} {
	printf("OR\n");
	return OR;
}

{PROCEDURE} {
	printf("PROCEDURE\n");
	return PROCEDURE;
}

{READ} {
	printf("READ\n");
	return READ;
}

{THEN} {
	printf("THEN\n");
	return THEN;
}

{TO} {
	printf("TO\n");
	return TO;
}

{WHILE} {
	printf("WHILE\n");
	return WHILE;
}

{WRITE} {
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

{LT} {
	printf("LT\n");
	return LT;
}

{LE} {
	printf("LE\n");
	return LE;
}

{EQ} {
	printf("EQ\n");
	return EQ;
}

{NE} {
	printf("NE\n");
	return NE;
}

{GT} {
	printf("GT\n");
	return GT;
}

{GE} {
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

{NAME} {
	printf("NAME\n");
	return NAME;
}

{NUMBER} {
	printf("NUMBER\n");
	return NUMBER;
}

{CHARCONST} {
	printf("CHARCONST\n");	
	return CHARCONST;
}

"//".* {
	printf("//");
}

[ \t]* {
	printf("BLANK\n");
}

[\n] {
	yylineno++;
}

. {
	printf("unexpected character\n");
}
%%

/* user code */
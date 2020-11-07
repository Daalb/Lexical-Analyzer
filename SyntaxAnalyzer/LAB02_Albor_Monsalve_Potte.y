%{
    #include <stdio.h>
    #include <stdlib.h>

	extern int yylex();
	extern int yyparse();
	extern FILE* yyin;
	extern FILE * yyout;
	extern int yylineno;
	extern char *yytext;
	int errores = 0;
	void yyerror(const char *s);
%}

%token IF ELSE FOR WHILE 
%token DOUBLE INT STRING CHAR
%token NEW PUBLIC CLASS RETURN STATIC VOID
%left MULT SUMA RESTA DIV ASIG MOD AND OR NOT
%token MASMAS MENMEN ASIGMAS ASIGMEN ASIGMULT ASIGDIV
%token LLAVEA LLAVEC PARENTA PARENTC CORCHETEA CORCHETEC PUNTOCOMA
%left IGUAL MENORIGUAL MAYORIGUAL DIFERENTE MAYOR MENOR
%token ENTERO CADENA COMENTARIO REAL ID
%start init
%%

init    : ejemplo
		| init ejemplo	
        ;

ejemplo : IF PARENTA ID PARENTC PUNTOCOMA
		;	

%%

int main(){
	yyin=fopen("Archivo.txt","r");
	yyout=fopen("ArchivoSalida.txt","w");
	do {
	
		yyparse();

	} while(!feof(yyin));

	if(errores==0){
		fprintf(yyout, "No hubo ningun error sintactico.");
		fprintf(stderr, "No hubo ningun error sintactico.\n");
	}	
}

void yyerror (const char *s) {
    errores++;
	if(strcmp(yytext,"\n")==0){
		fprintf(yyout, "La línea %d tiene un error de tipo: %s\n",(yylineno-1),s);
		fprintf(stderr, "La línea %d tiene un error de tipo: %s\n",(yylineno-1),s);
	}else{
		fprintf(yyout, "La línea %d tiene un error de tipo: %s\n",yylineno,s);
		fprintf(stderr, "La línea %d tiene un error de tipo: %s\n",yylineno,s);
	}
}
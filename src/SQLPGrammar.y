%token IMPLIES OR AND NOT LE GE NE HAS MAX MIN AS ASC DESC MOD ASSIGN EQ STAR

%token SIZE SELECTIVITY OVERLAP
%token FREQUENCY UNIT TIME SPACE

%token IDENTIFIER CONSTANT STRING_LITERAL SIZEOF

%token STORE STORING DYNAMIC STATIC OF TYPE ORDERED BY
%token INDEX LIST ARRAY BINARY TREE DISTRIBUTED POINTER

%token SCHEMA  CLASS ISA PROPERTIES CONSTRAINTS PROPERTY
%token ON DETERMINED COVER QUERY GIVEN FROM SELECT WHERE ORDER
%token PRECOMPUTED ONE EXIST FOR ALL TRANSACTION INTCLASS STRCLASS
%token INTEGER REAL DOUBLEREAL STRING MAXLEN RANGE TO
%token INSERT END CHANGE DELETE DECLARE RETURN UNION

%start SQLPProgram
%%
SQLPProgram
    : Query
        { printf("Input Query"); }

Identifier
	: IDENTIFIER
		{ printf("|%s| ", yytext); }
	;
 
Query
	: SELECT_QUERY
		{printf("Select Query");}
	| UNION_QUERY
		{printf("Union Query");}
		;

SELECT_QUERY
	: '(' QUERY ')'
		{printf(" '{' QUERY '}'");}
	| SELECT SELECTLIST BODY
		{printf("SQLP Query");}
	;

BODY
	: FROM TablePath
		{ printf("Body 1 "); }
	| FROM TablePath WHERE ATTRPATH EQ ATTRPATH
		{ printf("Body 2 "); }
	;

TablePath
    : Identifier Identifier
        {}
    | Identifier Identifier "," TablePath
        {}
    ;

UNION_QUERY
   : SELECT_QUERY
        {}
   | SELECT_QUERY UNION UNION_QUERY
   ;

SELECTLIST
	: STAR
    | Identifier
	| Identifier "," SELECTLIST
		{ printf("Select list"); }
	;

ATTRPATH 
	: Identifier
	| Identifier '.' ATTRPATH
		{printf("Path Function");}
	;


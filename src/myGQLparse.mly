%{
  open MyGQLast;;
%}

// %token LET REC LETREC IN FUN ARROW
// %token IF THEN ELSE


%token <int> INT
%token <string> IDENT
%token TRUE FALSE
%token <string> STRING
%token <string> COMMAND

%token LPAR RPAR LBRACE RBRACE COLON SEMICOLON COMMA
%token LRELARROW RRELARROWDIR //RRELARROW LRELARROWDIR
//%token PIPE

// %token PLUS MINUS MULT DIV
// %token EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
// %token LBRACKET RBRACKET
// %left EQUAL GREATER SMALLER GREATEREQUAL SMALLEREQUAL
// %left PLUS MINUS
// %left MULT DIV


%start main
%type <MyGQLast.command list> main

%%

main: instr SEMICOLON { $1 }
;

instr:
| COMMAND             { [ECommand($1, EUnit)] }
| COMMAND expr        { [ECommand($1, $2)] }
| COMMAND expr instr  { ECommand($1, $2)::$3 }
;

expr:
| entity { $1 }
| atom { $1 }
;

atom:
| INT            { EInt ($1) }
| TRUE           { EBool (true) }
| FALSE          { EBool (false) }
| STRING         { EString ($1) }
| IDENT          { EIdent ($1) }
;

entity:
| node          { $1 }
| relationship  { $1 }
;

node:
| LPAR opt_ident opt_labels opt_props RPAR { ENode($2, $3, $4) }
;

relationship:
| node LRELARROW opt_ident opt_rtype opt_props RRELARROWDIR node { ERel($3, $4, $5, $1, $7)}
;

opt_ident:
| { None }
| IDENT { Some $1 }
;

opt_labels:
| { [] }
| COLON IDENT opt_labels { $2 :: $3 }
;

opt_rtype:
| { None }
| COLON IDENT { Some $2 }
// | opt_rtype PIPE STRING { EOr($1,$3) }
;

opt_props:
| { [] }
| LBRACE props RBRACE  { $2 }
;

props:
| property              { [$1] }
| property COMMA props  { $1 :: $3 }
;

property:
| IDENT COLON atom { ($1, $3) }
;


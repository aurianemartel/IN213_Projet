type token =
  | INT of (
# 9 "myGQLparse.mly"
        int
# 6 "myGQLparse.mli"
)
  | IDENT of (
# 10 "myGQLparse.mly"
        string
# 11 "myGQLparse.mli"
)
  | TRUE
  | FALSE
  | STRING of (
# 12 "myGQLparse.mly"
        string
# 18 "myGQLparse.mli"
)
  | COMMAND of (
# 13 "myGQLparse.mly"
        string
# 23 "myGQLparse.mli"
)
  | LPAR
  | RPAR
  | LBRACE
  | RBRACE
  | COLON
  | SEMICOLON
  | COMMA
  | LRELARROW
  | RRELARROWDIR

val main :
  (Lexing.lexbuf  -> token) -> Lexing.lexbuf -> MyGQLast.command list

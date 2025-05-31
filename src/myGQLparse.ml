type token =
  | INT of (
# 9 "myGQLparse.mly"
        int
# 6 "myGQLparse.ml"
)
  | IDENT of (
# 10 "myGQLparse.mly"
        string
# 11 "myGQLparse.ml"
)
  | TRUE
  | FALSE
  | STRING of (
# 12 "myGQLparse.mly"
        string
# 18 "myGQLparse.ml"
)
  | COMMAND of (
# 13 "myGQLparse.mly"
        string
# 23 "myGQLparse.ml"
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

open Parsing
let _ = parse_error;;
# 2 "myGQLparse.mly"
  open MyGQLast;;
# 39 "myGQLparse.ml"
let yytransl_const = [|
  259 (* TRUE *);
  260 (* FALSE *);
  263 (* LPAR *);
  264 (* RPAR *);
  265 (* LBRACE *);
  266 (* RBRACE *);
  267 (* COLON *);
  268 (* SEMICOLON *);
  269 (* COMMA *);
  270 (* LRELARROW *);
  271 (* RRELARROWDIR *);
    0|]

let yytransl_block = [|
  257 (* INT *);
  258 (* IDENT *);
  261 (* STRING *);
  262 (* COMMAND *);
    0|]

let yylhs = "\255\255\
\001\000\002\000\002\000\003\000\003\000\005\000\005\000\005\000\
\005\000\005\000\004\000\004\000\006\000\007\000\008\000\008\000\
\009\000\009\000\011\000\011\000\010\000\010\000\012\000\012\000\
\013\000\000\000"

let yylen = "\002\000\
\002\000\002\000\003\000\001\000\001\000\001\000\001\000\001\000\
\001\000\001\000\001\000\001\000\005\000\007\000\000\000\001\000\
\000\000\003\000\000\000\002\000\000\000\003\000\001\000\003\000\
\003\000\002\000"

let yydefred = "\000\000\
\000\000\000\000\000\000\026\000\000\000\006\000\010\000\007\000\
\008\000\009\000\000\000\000\000\004\000\005\000\000\000\012\000\
\001\000\016\000\000\000\003\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000\000\000\000\000\018\000\000\000\000\000\
\000\000\013\000\020\000\000\000\000\000\022\000\000\000\000\000\
\025\000\024\000\014\000"

let yydgoto = "\002\000\
\004\000\005\000\012\000\013\000\014\000\015\000\016\000\019\000\
\023\000\027\000\029\000\032\000\033\000"

let yysindex = "\009\000\
\017\255\000\000\255\254\000\000\014\255\000\000\000\000\000\000\
\000\000\000\000\023\255\017\255\000\000\000\000\016\255\000\000\
\000\000\000\000\018\255\000\000\023\255\025\255\019\255\020\255\
\018\255\030\255\026\255\031\255\019\255\000\000\024\255\027\255\
\028\255\000\000\000\000\021\255\015\255\000\000\030\255\032\255\
\000\000\000\000\000\000"

let yyrindex = "\000\000\
\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\013\255\033\255\000\000\000\000\002\255\000\000\
\000\000\000\000\004\255\000\000\252\254\000\000\034\255\000\255\
\004\255\000\000\000\000\000\000\029\255\000\000\000\000\000\000\
\036\255\000\000\000\000\000\000\000\000\000\000\000\000\000\000\
\000\000\000\000\000\000"

let yygindex = "\000\000\
\000\000\026\000\000\000\000\000\003\000\007\000\000\000\022\000\
\023\000\020\000\000\000\011\000\000\000"

let yytablesize = 50
let yytable = "\006\000\
\007\000\008\000\009\000\010\000\015\000\011\000\015\000\011\000\
\019\000\001\000\015\000\017\000\017\000\011\000\019\000\006\000\
\007\000\008\000\009\000\010\000\015\000\015\000\003\000\015\000\
\018\000\017\000\025\000\026\000\022\000\021\000\028\000\031\000\
\035\000\034\000\037\000\040\000\038\000\020\000\011\000\041\000\
\039\000\021\000\024\000\021\000\002\000\023\000\043\000\030\000\
\036\000\042\000"

let yycheck = "\001\001\
\002\001\003\001\004\001\005\001\009\001\007\001\011\001\006\001\
\009\001\001\000\015\001\008\001\009\001\012\001\015\001\001\001\
\002\001\003\001\004\001\005\001\008\001\009\001\006\001\011\001\
\002\001\012\001\002\001\009\001\011\001\014\001\011\001\002\001\
\002\001\008\001\011\001\015\001\010\001\012\000\007\001\037\000\
\013\001\008\001\021\000\015\001\012\001\010\001\040\000\025\000\
\029\000\039\000"

let yynames_const = "\
  TRUE\000\
  FALSE\000\
  LPAR\000\
  RPAR\000\
  LBRACE\000\
  RBRACE\000\
  COLON\000\
  SEMICOLON\000\
  COMMA\000\
  LRELARROW\000\
  RRELARROWDIR\000\
  "

let yynames_block = "\
  INT\000\
  IDENT\000\
  STRING\000\
  COMMAND\000\
  "

let yyact = [|
  (fun _ -> failwith "parser")
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : 'instr) in
    Obj.repr(
# 32 "myGQLparse.mly"
                      ( _1 )
# 152 "myGQLparse.ml"
               : MyGQLast.command list))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 0 : 'expr) in
    Obj.repr(
# 36 "myGQLparse.mly"
               ( [ECommand(_1, _2)] )
# 160 "myGQLparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'expr) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'instr) in
    Obj.repr(
# 37 "myGQLparse.mly"
                     ( ECommand(_1, _2)::_3 )
# 169 "myGQLparse.ml"
               : 'instr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'entity) in
    Obj.repr(
# 41 "myGQLparse.mly"
         ( _1 )
# 176 "myGQLparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 42 "myGQLparse.mly"
       ( _1 )
# 183 "myGQLparse.ml"
               : 'expr))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : int) in
    Obj.repr(
# 46 "myGQLparse.mly"
                 ( EInt (_1) )
# 190 "myGQLparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 47 "myGQLparse.mly"
                 ( EBool (true) )
# 196 "myGQLparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    Obj.repr(
# 48 "myGQLparse.mly"
                 ( EBool (false) )
# 202 "myGQLparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 49 "myGQLparse.mly"
                 ( EString (_1) )
# 209 "myGQLparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 50 "myGQLparse.mly"
                 ( EIdent (_1) )
# 216 "myGQLparse.ml"
               : 'atom))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'node) in
    Obj.repr(
# 54 "myGQLparse.mly"
                ( _1 )
# 223 "myGQLparse.ml"
               : 'entity))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'relationship) in
    Obj.repr(
# 55 "myGQLparse.mly"
                ( _1 )
# 230 "myGQLparse.ml"
               : 'entity))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 3 : 'opt_ident) in
    let _3 = (Parsing.peek_val __caml_parser_env 2 : 'opt_labels) in
    let _4 = (Parsing.peek_val __caml_parser_env 1 : 'opt_props) in
    Obj.repr(
# 59 "myGQLparse.mly"
                                           ( ENode(_2, _3, _4) )
# 239 "myGQLparse.ml"
               : 'node))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 6 : 'node) in
    let _3 = (Parsing.peek_val __caml_parser_env 4 : 'opt_ident) in
    let _4 = (Parsing.peek_val __caml_parser_env 3 : 'opt_rtype) in
    let _5 = (Parsing.peek_val __caml_parser_env 2 : 'opt_props) in
    let _7 = (Parsing.peek_val __caml_parser_env 0 : 'node) in
    Obj.repr(
# 63 "myGQLparse.mly"
                                                                 ( ERel(_3, _4, _5, _1, _7))
# 250 "myGQLparse.ml"
               : 'relationship))
; (fun __caml_parser_env ->
    Obj.repr(
# 67 "myGQLparse.mly"
  ( None )
# 256 "myGQLparse.ml"
               : 'opt_ident))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 68 "myGQLparse.mly"
        ( Some _1 )
# 263 "myGQLparse.ml"
               : 'opt_ident))
; (fun __caml_parser_env ->
    Obj.repr(
# 72 "myGQLparse.mly"
  ( [] )
# 269 "myGQLparse.ml"
               : 'opt_labels))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'opt_labels) in
    Obj.repr(
# 73 "myGQLparse.mly"
                         ( _2 :: _3 )
# 277 "myGQLparse.ml"
               : 'opt_labels))
; (fun __caml_parser_env ->
    Obj.repr(
# 77 "myGQLparse.mly"
  ( None )
# 283 "myGQLparse.ml"
               : 'opt_rtype))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 0 : string) in
    Obj.repr(
# 78 "myGQLparse.mly"
              ( Some _2 )
# 290 "myGQLparse.ml"
               : 'opt_rtype))
; (fun __caml_parser_env ->
    Obj.repr(
# 83 "myGQLparse.mly"
  ( [] )
# 296 "myGQLparse.ml"
               : 'opt_props))
; (fun __caml_parser_env ->
    let _2 = (Parsing.peek_val __caml_parser_env 1 : 'props) in
    Obj.repr(
# 84 "myGQLparse.mly"
                       ( _2 )
# 303 "myGQLparse.ml"
               : 'opt_props))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 0 : 'property) in
    Obj.repr(
# 88 "myGQLparse.mly"
                        ( [_1] )
# 310 "myGQLparse.ml"
               : 'props))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : 'property) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'props) in
    Obj.repr(
# 89 "myGQLparse.mly"
                        ( _1 :: _3 )
# 318 "myGQLparse.ml"
               : 'props))
; (fun __caml_parser_env ->
    let _1 = (Parsing.peek_val __caml_parser_env 2 : string) in
    let _3 = (Parsing.peek_val __caml_parser_env 0 : 'atom) in
    Obj.repr(
# 93 "myGQLparse.mly"
                   ( (_1, _3) )
# 326 "myGQLparse.ml"
               : 'property))
(* Entry main *)
; (fun __caml_parser_env -> raise (Parsing.YYexit (Parsing.peek_val __caml_parser_env 0)))
|]
let yytables =
  { Parsing.actions=yyact;
    Parsing.transl_const=yytransl_const;
    Parsing.transl_block=yytransl_block;
    Parsing.lhs=yylhs;
    Parsing.len=yylen;
    Parsing.defred=yydefred;
    Parsing.dgoto=yydgoto;
    Parsing.sindex=yysindex;
    Parsing.rindex=yyrindex;
    Parsing.gindex=yygindex;
    Parsing.tablesize=yytablesize;
    Parsing.table=yytable;
    Parsing.check=yycheck;
    Parsing.error_function=parse_error;
    Parsing.names_const=yynames_const;
    Parsing.names_block=yynames_block }
let main (lexfun : Lexing.lexbuf -> token) (lexbuf : Lexing.lexbuf) =
   (Parsing.yyparse yytables 1 lexfun lexbuf : MyGQLast.command list)

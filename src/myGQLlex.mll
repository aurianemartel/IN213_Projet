{
  open MyGQLparse ;;
  exception Eoi ;;

  let initial_string_buffer = Bytes.create 256;;
  let string_buff = ref initial_string_buffer;;
  let string_index = ref 0;;

  let reset_string_buffer () =
    string_buff := initial_string_buffer;
    string_index := 0;;

  let store_string_char c =
    if !string_index >= Bytes.length (!string_buff) then begin
      let new_buff = Bytes.create (Bytes.length (!string_buff) * 2) in
      Bytes.blit (!string_buff) 0 new_buff 0 (Bytes.length (!string_buff));
      string_buff := new_buff
    end;
    Bytes.unsafe_set (!string_buff) (!string_index) c;
    incr string_index;;

  let get_stored_string () =
    let s = Bytes.to_string (Bytes.sub (!string_buff) 0 (!string_index)) in
    string_buff := initial_string_buffer;
    s;;

exception LexError of (Lexing.position * Lexing.position) ;;

}

rule lex = parse
    ' ' | '\t' | '\n' {lex lexbuf}
  | ['0'-'9']+ as lxm
      { INT(int_of_string lxm) }
  | [ 'A'-'Z' 'a'-'z' ] [ 'A'-'Z' 'a'-'z' '_' '0'-'9']* as lxm
      { match lxm with
        | "true" -> TRUE
        | "false" -> FALSE 
        | "MATCH" | "RETURN" | "CREATE" -> COMMAND(lxm)
        | _ -> IDENT(lxm) }
  | '('   { LPAR }
  | ')'   { RPAR }
  | '{'   { LBRACE }
  | '}'   { RBRACE }
  | ":"   { COLON }
  | ";"   { SEMICOLON }
  | ","   { COMMA }
  | "]->" { RRELARROWDIR }
  | "-["  { LRELARROW }
  (* | "|"   { PIPE } *)
  | '"'   { reset_string_buffer();
            in_string lexbuf;
            STRING (get_stored_string()) }
  | "//"  { in_cpp_comment lexbuf }
  | "/*"  { in_c_comment lexbuf }
  | eof   { raise Eoi }
  | _     { raise (LexError (lexbuf.Lexing.lex_start_p,
                             lexbuf.Lexing.lex_curr_p)) }

and in_string = parse
    '"'
      { () }
  | eof
      { raise Eoi }
  | _ as c
      { store_string_char c; in_string lexbuf }

and in_cpp_comment = parse
    '\n' { lex lexbuf }
  | _    { in_cpp_comment lexbuf }
  | eof  { raise Eoi }

and in_c_comment = parse
    "*/" { lex lexbuf }
  | _    { in_c_comment lexbuf }
  | eof  { raise Eoi }
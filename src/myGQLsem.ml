open MyGQLast;;
let myGraph = MyGQLdomain.init_graph 100;;

(* Environnement. *)
let init_env = [] ;;

let error msg = raise(Failure msg) ;;

let extend rho x v = (x, v) :: rho ;;

let lookup var_name rho =
  try List.assoc var_name rho
  with Not_found -> error (Printf.sprintf "Undefined ident '%s'" var_name)
;;


type myGQLval = 
  | Intval of int
  | Stringval of string
  | Boolval of bool
  | Nodeval of ((string option) * (string list) * ((string * expr) list))
;;

let printval = function 
  | Intval n -> Printf.printf "%d" n
  | Boolval b -> Printf.printf "%s" (if b then "true" else "false")
  | Stringval s -> Printf.printf "%S" s
  | Nodeval n -> raise(Failure "A FINIR")
;;
let rec printvals = function
  | [] -> ()
  | value::reste -> printval value; printvals reste
;;

let match_eval entity rho = match entity with
  | ENode _ -> raise(Failure "A FINIR")
  | ERel _ -> raise(Failure "A FINIR")
  | _ -> raise(Failure "Command MATCH should take entity value : node or relationship")
;;

let create_eval entity rho = match entity with
  | ENode _ -> raise(Failure "A FINIR")
  | ERel _ -> raise(Failure "A FINIR")
  | _ -> raise(Failure "Command CREATE should take entity value : node or relationship")
;;

let eval_expr expr rho = match expr with 
  | EInt n -> [Intval n]
  | EString s -> [Stringval s]
  | EBool b -> [Boolval b]
  | EIdent s -> lookup s rho
  | _ -> raise(Failure "Expr non supportée")
;;

let rec eval_command command rho = match command with
  | ECommand("MATCH", entity) -> match_eval entity rho
  | ECommand("CREATE", entity) -> create_eval entity rho
  | _ -> raise(Failure "A FINIR")
;;

let rec eval instr rho = match instr with
  | [] -> []
  | [ECommand("RETURN", variable)] -> eval_expr variable rho
  | commande::reste -> eval reste rho
;;

let eval_init i = eval i init_env;;
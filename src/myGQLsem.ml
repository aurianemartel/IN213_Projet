open MyGQLast;;
open MyGQLval;;
let myGraph = MyGQLdomain.init_graph 100;;

(* Environnement. *)
let init_env = [] ;;

let error msg = raise(Failure msg) ;;

let extend rho x v = (x, v) :: rho ;;

let lookup var_name rho =
  try List.assoc var_name rho
  with Not_found -> error (Printf.sprintf "Undefined ident '%s'" var_name)
;;

let eval_dump () = 
  let ln = MyGQLdomain.get_node_list myGraph in
  let lr = MyGQLdomain.get_edge_list myGraph in 
  ln@lr
;;

let match_eval entity rho = match entity with
  | ENode _ -> raise(Failure "A FINIR")
  | ERel _ -> raise(Failure "A FINIR")
  | _ -> raise(Failure "Command MATCH should take entity value : node or relationship")
;;

let eval_create entity rho = match entity with
  | ENode(name, label_list, properties) -> 
      let n = match name with
        | None -> raise(Failure "A FINIR")
        | Some sname -> sname in
      let val_properties = List.map (fun p -> match p with 
        |k, EInt(n) -> k, Intval(n)
        |k, EString(s) -> k, Stringval(s)
        |k, EBool(b) -> k, Boolval(b)
        |k, EIdent(s) -> raise(Failure "A FINIR")
        |_ -> raise(Failure "Unnaccepted property type")
      ) properties in
      MyGQLdomain.create_node myGraph.graph_structure myGraph.node_table n label_list val_properties;
      [Nodeval(n, label_list, val_properties)]
  | ERel _ -> raise(Failure "A FINIR CREATE Relval")
  | _ -> raise(Failure "Command CREATE should take entity value : node or relationship")
;;

let eval_expr expr rho = match expr with 
  | EInt n -> [Intval n]
  | EString s -> [Stringval s]
  | EBool b -> [Boolval b]
  | EIdent s -> lookup s rho
  | _ -> raise(Failure "Expr non supportée")
;;

(* let rec eval_command command rho = match command with
  | ECommand("MATCH", entity) -> match_eval entity rho
  | ECommand("CREATE", entity) -> create_eval entity rho
  | _ -> raise(Failure "A FINIR")
;; *)

let rec eval instr rho = match instr with
  | [] -> []
  | [ECommand("DUMP", EUnit)] -> eval_dump ()
  | [ECommand("RETURN", variable)] -> eval_expr variable rho
  | [ECommand("CREATE", entity)] -> eval_create entity rho
  | commande::reste -> eval reste rho
;;

let eval_init i = eval i init_env;;
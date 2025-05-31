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
  | Nodeval of (string * (string list) * ((string * myGQLval) list))
;;

let printval = function 
  | Intval n -> Printf.printf "%d" n
  | Boolval b -> Printf.printf "%s" (if b then "true" else "false")
  | Stringval s -> Printf.printf "%S" s
  | Nodeval(name, label_list, properties) -> 
      Printf.printf "Ajout du noeud : (%s%a {%a})"
      name
      (fun oc -> List.iter (fun s -> Printf.printf ":%s" s)) label_list
      (fun oc -> List.iter (fun s -> match s with
        |k, Intval v -> Printf.fprintf oc " %s:%d" k v
        |k, Stringval v -> Printf.fprintf oc " %s:%s" k v
        |k, Boolval v -> Printf.fprintf oc " %s:%b" k v
        |_  -> raise(Failure "Bad property type"))) properties
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

let eval_create entity rho = match entity with
  | ENode(name, label_list, properties) -> 
      let n = match name with
        | None -> raise(Failure "A FINIR")
        | Some sname -> sname in
      let dom_properties = List.map (fun p -> match p with 
        |k, EInt(n) -> k, MyGQLdomain.PInt(n)
        |k, EString(s) -> k, MyGQLdomain.PString(s)
        |k, EBool(b) -> k, MyGQLdomain.PBool(b)
        |k, EIdent(s) -> raise(Failure "A FINIR")
        |_ -> raise(Failure "Unnaccepted property type")
      ) properties in
      MyGQLdomain.create_node myGraph.graph_structure myGraph.node_table n label_list dom_properties;
      let val_properties = List.map (fun p -> match p with 
        |k, EInt(n) -> k, Intval(n)
        |k, EString(s) -> k, Stringval(s)
        |k, EBool(b) -> k, Boolval(b)
        |k, EIdent(s) -> raise(Failure "A FINIR")
        |_ -> raise(Failure "Unnaccepted property type")
      ) properties in
      [Nodeval(n, label_list, val_properties)]
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

(* let rec eval_command command rho = match command with
  | ECommand("MATCH", entity) -> match_eval entity rho
  | ECommand("CREATE", entity) -> create_eval entity rho
  | _ -> raise(Failure "A FINIR")
;; *)

let rec eval instr rho = match instr with
  | [] -> []
  | [ECommand("RETURN", variable)] -> eval_expr variable rho
  | [ECommand("CREATE", entity)] -> eval_create entity rho
  | commande::reste -> eval reste rho
;;

let eval_init i = eval i init_env;;
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

let eval_match entity rho = match entity with
  | ENode( name, labels, _ ) -> (match name with
    | None -> rho
    | Some n ->
        let node_list = MyGQLdomain.match_node myGraph labels in
        extend rho n node_list)
  | ERel _ -> raise(Failure "A FINIR")
  | _ -> raise(Failure "Command MATCH should take entity value : node or relationship")
;;

let eval_create entity rho = 
  let translate_props properties = List.map (fun p -> match p with 
        |k, EInt(n) -> k, Intval(n)
        |k, EString(s) -> k, Stringval(s)
        |k, EBool(b) -> k, Boolval(b)
        |k, EIdent(s) -> raise(Failure "A FINIR")
        |_ -> raise(Failure "Unnaccepted property type")
  ) properties in match entity with
    | ENode(name, label_list, properties) -> 
        let n = match name with
          | None -> raise(Failure "A FINIR")
          | Some sname -> sname in
        let val_properties = translate_props properties in
        MyGQLdomain.create_node myGraph.graph_structure myGraph.node_table n label_list val_properties;
        []
    | ERel ( None, rtype, props, node1, node2 ) -> 
      let n1, n2 = (match node1, node2 with
        | ENode(Some n1, _, _),  ENode(Some n2, _, _) -> n1, n2
        | _ -> raise(Failure "CREATE relationship needs named nodes")
    ) in let rel_type = (match rtype with
        | Some srtype -> srtype
        | None -> raise(Failure "CREATE relationship needs a type")
    ) in
    let val_properties = translate_props props in
      MyGQLdomain.create_edge myGraph.graph_structure myGraph.edge_table n1 n2 rel_type val_properties;
      []
    | _ -> raise(Failure "Command CREATE should take entity value : node or relationship")
;;

let eval_expr expr rho = match expr with 
  | EInt n -> [Intval n]
  | EString s -> [Stringval s]
  | EBool b -> [Boolval b]
  | EIdent s -> lookup s rho
  | _ -> raise(Failure "Expr non supportée")
;;

let rec eval instr rho = match instr with
  | [] -> []
  | [ECommand("DUMP", EUnit)] -> eval_dump ()
  | [ECommand("RETURN", variable)] -> eval_expr variable rho
  | [ECommand("CREATE", entity)] -> eval_create entity rho
  | ECommand("MATCH", entity)::reste -> 
      let newrho = eval_match entity rho in eval reste newrho
  | commande::reste -> eval reste rho
;;

let eval_init i = eval i init_env;;
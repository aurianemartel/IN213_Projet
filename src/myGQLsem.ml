open MyGQLast;;
open MyGQLval;;
let myGraph = MyGQLdomain.init_graph 100;;

(* Environnement. *)
let init_env = [] ;;

let error msg = raise(Failure msg) ;;

let extend rho x v = (x, v) :: rho ;;

let lookup var_name rho = List.assoc var_name rho;;

let eval_dump () = 
  let ln = MyGQLdomain.get_node_list myGraph in
  let lr = MyGQLdomain.get_edge_list myGraph in 
  ln@lr
;;

let get_node_from_ident n rho labels = 
  try lookup n rho 
  with Not_found -> try if MyGQLdomain.node_mem myGraph n labels
      then let node = MyGQLdomain.make_nodeval myGraph n in
      [node]
    else raise(Failure "Unidentified ident")
  with MyGQLdomain.Impossible_node -> []
;;

let rec eval_match entity rho = match entity with
  | ENode( name, labels, _ ) -> (match name with
    | None -> rho
    | Some n -> 
      try if MyGQLdomain.node_mem myGraph n labels
          then rho
        else let node_list = MyGQLdomain.match_node myGraph labels in
        extend rho n node_list
      with MyGQLdomain.Impossible_node -> extend rho n [])
  | ERel ( name, rtype, _, node1, node2 ) -> 
      let rho1 = eval_match node1 rho in
      let rho2 = eval_match node2 rho1 in
      let node_list1 = (match node1 with
        | ENode(Some n1, labels,_) -> get_node_from_ident n1 rho2 labels
        | ENode(None, labels, _) -> MyGQLdomain.match_node myGraph labels
        | _ -> raise(Failure "Relationship is between nodes")) 
      and node_list2 = (match node2 with
        | ENode(Some n2, labels,_) -> get_node_from_ident n2 rho2 labels
        | ENode(None, labels, _) -> MyGQLdomain.match_node myGraph labels
        | _ -> raise(Failure "Relationship is between nodes")) in 
      let edge_list, new_nl1, new_nl2 = MyGQLdomain.match_edge myGraph node_list1 node_list2 rtype in
      let rho3 = (match node1 with
        | ENode(Some n1,_,_) -> extend rho n1 new_nl1
        | _ -> rho) in
      let rho4 = (match node2 with
        | ENode(Some n2,_,_) -> extend rho3 n2 new_nl2
        | _ -> rho3) in
      let rho5 = (match name with
        | Some rn -> extend rho4 rn edge_list
        | None -> rho4) in 
      rho5
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
  | EIdent s -> get_node_from_ident s rho []
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
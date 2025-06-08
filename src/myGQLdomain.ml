module G = Graph.Imperative.Digraph.Concrete(String)

type node_info = { 
  label_list : string list; 
  prop_list : (string*MyGQLval.myGQLval) list
}

type rel_info = { 
  rel_type : string; 
  prop_list : (string*MyGQLval.myGQLval) list 
}

type full_graph = { 
  graph_structure : G.t; 
  node_table : (string, node_info) Hashtbl.t; 
  edge_table : (string*string, rel_info) Hashtbl.t 
}

let init_graph size = 
  let g = G.create () in
  let vertex_table : (string, node_info) Hashtbl.t = Hashtbl.create size in
  let edge_table : (string*string, rel_info) Hashtbl.t = Hashtbl.create size in
  let fg = { 
    graph_structure = g; 
    node_table = vertex_table; 
    edge_table = edge_table 
  } in fg;;

let create_node graph vertex_table name labels properties = 
  let info_table = { label_list = labels; prop_list = properties} in
  Hashtbl.add vertex_table name info_table;
  G.add_vertex graph name;;

let create_edge graph edge_table node1 node2 relationship_type propetries = 
  let info_table = { rel_type = relationship_type; prop_list = propetries } in
  Hashtbl.add edge_table (node1, node2) info_table;
  G.add_edge graph node1 node2;;


(* val fold_vertex : (vertex -> 'a -> 'a) -> t -> 'a -> 'a *)

let make_nodeval full_graph v = 
  let info_table = Hashtbl.find full_graph.node_table v in
  let labels = info_table.label_list
  and properties = info_table.prop_list in 
  MyGQLval.Nodeval(v, labels, properties)
;;

let make_relval full_graph v1 v2 = 
  let info_table = Hashtbl.find full_graph.edge_table (v1,v2) in
  let rtype = info_table.rel_type
  and properties = info_table.prop_list in 
  let node1 = make_nodeval full_graph v1
  and node2 = make_nodeval full_graph v2 in
  MyGQLval.Relval(rtype, properties, node1, node2)
;;

let get_node_list full_graph = G.fold_vertex 
  (fun v l -> 
    let nodeval = make_nodeval full_graph v in
    nodeval::l)
  full_graph.graph_structure [];;

let get_edge_list full_graph = G.fold_edges 
  (fun v1 v2 l -> 
    let info_table = Hashtbl.find full_graph.edge_table (v1,v2) in
    let rtype = info_table.rel_type
    and properties = info_table.prop_list in 
    let nodeval1 = make_nodeval full_graph v1
    and nodeval2 = make_nodeval full_graph v2 in
    MyGQLval.Relval(rtype, properties, nodeval1, nodeval2)::l
  )
  full_graph.graph_structure [];;

exception Impossible_node;;

let node_mem full_graph node match_labels = 
  if G.mem_vertex full_graph.graph_structure node
    then let info_table = Hashtbl.find full_graph.node_table node in
    let node_labels = info_table.label_list in
    let rec matching liste = (match liste with 
      | [] -> true
      | label::reste -> 
        if (List.mem label node_labels) 
        then matching reste
        else raise Impossible_node
    ) in matching match_labels
  else false;;

let match_node full_graph match_labels = G.fold_vertex 
  (fun v l -> 
    let info_table = Hashtbl.find full_graph.node_table v in
    let vlabels = info_table.label_list
    and vproperties = info_table.prop_list in 
    let rec matching liste = (match liste with 
      | [] -> true
      | label::reste -> 
        if (List.mem label vlabels) 
        then matching reste
        else false
    ) in if (matching match_labels)
      then MyGQLval.Nodeval(v, vlabels, vproperties)::l
      else l
  ) 
  full_graph.graph_structure [];;

let match_edge full_graph node_list1 node_list2 rtype = 
  let edge_list = G.fold_edges (fun v1 v2 l -> 
    let info_table = Hashtbl.find full_graph.edge_table (v1,v2) in
    if (match rtype with 
      | Some rt -> 
          (* Printf.printf ">>> %s ?= %s\n" rt info_table.rel_type;  *)
          not (String.equal rt info_table.rel_type)
      | None -> false) then l
    else if (List.exists
    (fun node -> match node with
      | MyGQLval.Nodeval(name, _, _) -> (name = v1)
      | _ -> false)
    node_list1) && (List.exists 
    (fun node -> match node with
      | MyGQLval.Nodeval(name, _, _) -> (name = v2)
      | _ -> false)
    node_list2) then let relval = make_relval full_graph v1 v2 in relval::l
    else l) full_graph.graph_structure [] in
  let rec gnls el nl1 nl2 = match el with
    | [] -> nl1, nl2
    | MyGQLval.Relval(_, _, node1, node2)::reste -> gnls reste (node1::nl1) (node2::nl2)
    | _ -> raise(Failure "Wrong types for relationship")
  in let nl1, nl2 = gnls edge_list [] [] in
  edge_list, nl1, nl2;;
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

let get_node_list full_graph = G.fold_vertex 
  (fun v l -> 
    let info_table = Hashtbl.find full_graph.node_table v in
    let labels = info_table.label_list
    and properties = info_table.prop_list in 
    MyGQLval.Nodeval(v, labels, properties)::l
  ) 
  full_graph.graph_structure [];;

let get_edge_list graph = [];;

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
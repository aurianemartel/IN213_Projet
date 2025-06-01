type expr =
  | EUnit
  | EInt of int
  | EBool of bool
  | EString of string
  | EIdent of string
  | ENode of ((string option) * (string list) * ((string * expr) list))
  | ERel of ((string option) * (string option) * ((string * expr) list) * expr * expr)
  

type command = 
  | ECommand of (string * expr)


let rec  print_expr oc = function
  | EUnit -> ()
  | EInt n -> Printf.fprintf oc "%d" n
  | EBool b -> Printf.fprintf oc "%s" (if b then "true" else "false")
  | EIdent s -> Printf.fprintf oc "%s" s
  | EString s -> Printf.fprintf oc "\"%s\"" s
  | ENode (name, attributes, props) -> (
      let sname = match name with
        | None -> ""
        | Some s -> s in
      Printf.fprintf oc "Noeud (Nom : %s, Attributs :%a, Propriétés :%a)" 
      sname 
      (fun oc -> List.iter (fun s -> Printf.fprintf oc " %s" s)) attributes
      (fun oc -> List.iter (fun s -> match s with
        |k, EInt v -> Printf.fprintf oc " %s:%d" k v
        |k, EString v -> Printf.fprintf oc " %s:%s" k v
        |k, EBool v -> Printf.fprintf oc " %s:%b" k v
        |_  -> raise(Failure "Bad property type"))) props
    )
  | ERel (name, rtype, props, node1, node2) -> (
      let sname = match name with
        | None -> ""
        | Some s -> s in
      let srtype = match rtype with
        | None -> ""
        | Some s -> s in
      Printf.fprintf oc "Relationship (Nom : %s, Type : %s, De : %a  A : %a)" 
      sname srtype
       print_expr node1
       print_expr node2
    )
;;

let rec print oc = function
  | [] -> Printf.fprintf oc ";"
  | ECommand (commande, e)::reste -> 
      Printf.fprintf oc "%s %a\n" commande print_expr e;
      print oc reste
;;
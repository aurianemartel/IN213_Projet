type myGQLval = 
  | Intval of int
  | Stringval of string
  | Boolval of bool
  | Nodeval of (string * (string list) * ((string * myGQLval) list))
  | Relval of ((string option) * (string option) * ((string * myGQLval) list) * myGQLval * myGQLval)
;;

let printval = function 
  | Intval n -> Printf.printf "%d " n
  | Boolval b -> Printf.printf "%s " (if b then "true" else "false")
  | Stringval s -> Printf.printf "%s " s
  | Nodeval(name, label_list, properties) -> 
      Printf.printf "Noeud (%s%a {%a}) "
      name
      (fun oc -> List.iter (fun s -> Printf.printf ":%s" s)) label_list
      (fun oc -> List.iter (fun s -> match s with
        |k, Intval v -> Printf.fprintf oc " %s:%d" k v
        |k, Stringval v -> Printf.fprintf oc " %s:%s" k v
        |k, Boolval v -> Printf.fprintf oc " %s:%b" k v
        |_  -> raise(Failure "Bad property type"))) properties
  | Relval _ -> raise(Failure "A FINIR Relval")
;;

let rec printvals = function
  | [] -> ()
  | value::reste -> printval value; printvals reste
;;

open MyGQLast;;


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

let rec eval instr rho = match instr with
  | ECommand("MATCH", entity) -> match_eval entity rho
  | ECommand("CREATE", entity) -> create_eval entity rho
  | _ -> raise(Failure "A FINIR")
;;

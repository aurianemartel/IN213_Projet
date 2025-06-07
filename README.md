## Structure de fichier

- docu
- exs
    - create.gql
    - match.gql
- src 
    - myGQLlex.mll      : lexeur
    - myGQlparse.mly    : parseur
    - myGQLloop.ml  
    - myGQLast.ml
    - myGQLsem.ml
    - myGQLdomain.ml
    - myGQLval.ml


Prochaine étape : 
- CREATE : connecter sem et domain, node    [x]
- RETURN valeur                             [x]
- DUMP : noeuds                             [x]
- MATCH : pour un noeud                     [x]
- tester RETURN noeud                       [x]
- CREATE edge (connecter sem et domain)     [x]
- DUMP edge                                 []
- MATCH : avec une relation                 []

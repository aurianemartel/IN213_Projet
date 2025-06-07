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
- MATCH : pour un noeud                     []
- tester RETURN noeud                       []
- CREATE edge (connecter sem et domain)     []
- DUMP edge                                 []
- MATCH : avec une relation                 []

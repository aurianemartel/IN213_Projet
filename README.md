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


Prochaine étape : 
- CREATE : connecter sem et domain, node
- commande DUMP graphe
- CREATE edge (connecter sem et domain)
- MATCH : pour un noeud
- tester RETURN
- MATCH : avec une relation

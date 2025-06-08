# Implémentation d'un petit langage de requêtes sur des graphes - myGQL - Auriane MARTEL

## Objectif et spécification

Ce langage a pour but de manipuler des bases de données sous formes de graphes, et d'effectuer des requêtes sur ces bases de données. Il est inspiré du langage OpenCypher, dont j'ai implémenté quelques fonctionnalités de base dans un interpréteur. Le graphe est géré dans la mémoire de travail de l'interpréteur.

Du côté DML - data manipulation - le mot clé CREATE permet d'ajouter des noeuds et relations entre ces noeuds au graphe.

Du côté DQL - data query - le mot clé MATCH permet de filtrer les noeuds ou relations pour obtenir ceux qui correspondent à des propriétés spécifiques, qui seront ensuite renvoyés grâce au mot-clé RETURN. On peut aussi afficher l'ensemble du graphe grâce au mot-clé DUMP.

Des fichiers exemples sont présents dans le répertoire exs, et peuvent être exécutés depuis le répertoire src avec la commande :
```
make exs
```

### Noeuds

Un noeud est de la forme : 
```
(nom:LABEL1:LABEL2 {propriete1: "valeur", propriete2: 1}) 
```
Il est créé avec la commande : 
```
CREATE (Alice:PERSONNE {age:18});
CREATE (Bob);
```
À la création, un noeud doit avoir un nom. Les autres paramètres sont facultatifs. 

On peut ensuite filtrer sur le nom ou les labels. On peut aussi remplacer le nom par une variable pour renvoyer la liste des noeuds obtenus lors du filtrage par labels.

```
// Trouver les noeuds avec le label PERSONNE
MATCH (n:PERSONNE)
RETURN n;

// Trouver les noeuds avec le label PERSONNE et le label GEEK
MATCH (n:PERSONNE:GEEK)
RETURN n;
```

### Relations

Une relation est un lien entre deux noeuds. Elle est de la forme :
```
(Noeud1)-[:REL_TYPE {propriete1: "valeur", propriete2: 1, propriete3: true}]->(Noeud2)
```
Elle a un type unique, et peut avoir plusieurs propriétés.

```
CREATE (Alice)-[:FRIEND]->(Bob);
```

Lors d'un match, on peut lui donner un nom (variable) à renvoyer dans le RETURN. On peut aussi affecter à une variable l'un des noeuds de la relation.

```
// Amis geeks de Alice
MATCH (Alice)-[:FRIEND]->(n:GEEK)
RETURN n;

// Relation entre Alice et Bob
MATCH (Alice)-[n]->(Bob)
RETURN n;
```

### Limitations de l'implémentation

- on ne peut avoir qu'une seule relation entre deux noeuds
- il n'y a pas de filtrage sur les propriétés (avec une commande WHERE)
- il n'y a pas d'opérations logiques sur les labels ou les types de relations (not "!" et or "|")
- il n'y a pas de opérations arithmétiques sur les résultats du RETURN
- il n'y a que 4 commandes implémentées

Le premier élément est limité par l'implémentation des graphes de la librairie ocamlgraph, et il faudrait donc modifier l'implétation dans myGQLdomain pour y remédier.

Les autres éléments sont compatibles avec l'implémentation actuelle du langage, qui est prévu pour pouvoir être enrichi facilement avec ces éléments.

## Structure de fichiers

- exs
    - create.gql        : exemples de CREATE sur des noeuds et relations
    - match.gql         : exemples de MATCH avec des noeuds et relations et RETURN complexes
    - return.gql        : exemples de RETURN simples
- src 
    - myGQLlex.mll      : lexeur
    - myGQlparse.mly    : parseur
    - myGQLloop.ml      : boucle d'interprétation
    - myGQLast.ml       : arbre de syntaxe des expressions, commandes et instructions
    - myGQLsem.ml       : fonctions d'évaluation espace expressions -> valeurs
    - myGQLdomain.ml    : fonctions auxiliaires du domaine, utilisées par myGQLsem.ml
    - myGQLval.ml       : définition des types de valeurs
    - Makefile

## Étapes de l'implémentation
- [x] lexeur et parseur complets
- [x] CREATE noeud   
- [x] RETURN valeur                    
- [x] DUMP : noeuds                             
- [x] MATCH : pour un noeud                     
- [x] RETURN noeud                       
- [x] CREATE edge     
- [x] DUMP : edges                                 
- [x] MATCH : avec une relation                 

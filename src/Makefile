# CAMLC=$(BINDIR)ocamlc
CAMLC=ocamlfind ocamlc
CAMLDEP=$(BINDIR)ocamldep
CAMLLEX=$(BINDIR)ocamllex
CAMLYACC=$(BINDIR)ocamlyacc
# COMPFLAGS=-w A-4-6-9 -warn-error A -g
COMPFLAGS=-package ocamlgraph

EXEC = myGQLloop

# Fichiers compilés, à produire pour fabriquer l'exécutable
SOURCES = myGQLast.ml myGQLval.ml myGQLdomain.ml myGQLsem.ml myGQLloop.ml
GENERATED = myGQLlex.ml myGQLparse.ml myGQLparse.mli
MLIS =
OBJS = $(GENERATED:.ml=.cmo) $(SOURCES:.ml=.cmo)

# Building the world
all: $(EXEC)

$(EXEC): $(OBJS)
	$(CAMLC) $(COMPFLAGS) $(OBJS) -o $(EXEC) -linkpkg

.SUFFIXES:
.SUFFIXES: .ml .mli .cmo .cmi .cmx
.SUFFIXES: .mll .mly

.ml.cmo:
	$(CAMLC) $(COMPFLAGS) -c $<

.mli.cmi:
	$(CAMLC) $(COMPFLAGS) -c $<

.mll.ml:
	$(CAMLLEX) $<

.mly.ml:
	$(CAMLYACC) $<

# Clean up
clean:
	rm -f *.cm[io] *.cmx *~ .*~ *.o
	rm -f parser.mli
	rm -f $(GENERATED)
	rm -f $(EXEC)

# Dependencies
depend: $(SOURCES) $(GENERATED) $(MLIS)
	$(CAMLDEP) $(SOURCES) $(GENERATED) $(MLIS) > .depend

include .depend

exs: $(EXEC)
	for f in ../exs/*.gql; \
		do echo "==>" $$f; \
		(./myGQLloop < $$f); \
	done;

exs_match: $(EXEC)
	./myGQLloop < ../exs/match.gql
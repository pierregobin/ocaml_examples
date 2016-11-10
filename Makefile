
EXE = web.native
all : $(EXE)

web.native : web.ml
	ocamlbuild -use-ocamlfind -pkgs netclient,lambdasoup $@

clean: 
	rm -rf *.out *.cmo *.cmi _build $(EXE)


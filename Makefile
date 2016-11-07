
all : web.out

web.out : web.ml
	ocamlfind ocamlc -package netclient,lambdasoup -o web.out web.ml -linkpkg

clean: 
	rm -rf *.out *.cmo


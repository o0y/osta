# osta
A static website generator in OCaml

## Compile

```
ocamlfind ocamlc -linkpkg -package omd str.cma osta.ml -o osta 
```

Create a page:
```
osta create 'A new page'
```

Render:
```
osta render
```

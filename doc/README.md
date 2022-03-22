## plg2nka
### A Haskell project
The program converts Right Linear Grammar to a Nondeterministic Finite Automaton. 

### Build and run
Build using `make` and run using `./flp-fun21 [-i -1 -2] (input_file)`

Example of an input file containing RLG G = (N,Sigma,P,S):
``
A,B
a,b,c
A
A->aaB
A->ccB
B->bB
B->#
``

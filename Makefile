#    Project: plg-2-nka (English: rlg-2-nfa)
#    Author:  Vít Barták (xbarta47)
#    Year:    2022


COMPILER=ghc
OBJ=src/Main.hs src/Parser.hs  src/Types.hs
BIN=flp21-fun
XLOGINXX=xbarta47

all: GHCFLAGS:=-Wall --make $(OBJ) -o $(BIN)
all: fun

fun: $(OBJ)
	$(COMPILER) $(GHCFLAGS)

zip: 
	zip -r flp-fun-xbarta47 src/*.hs doc/* test/* Makefile
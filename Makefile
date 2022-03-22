#    Project: rlg-2-nfa (Czech: plg-2-nka)
#    Author:   Vít Barták (xbarta47)
#    Date:   22.03.2022


COMPILER=ghc
OBJ=src/Main.hs src/Parser.hs
BIN=flp21-fun
XLOGINXX=xbarta47

all: GHCFLAGS:=-Wall --make $(OBJ) -o $(BIN)
all: fun

fun: $(OBJ)
	$(COMPILER) $(GHCFLAGS)

zip: 
	zip -r flp-fun-xbarta47 src/*.hs doc/* test/* Makefile
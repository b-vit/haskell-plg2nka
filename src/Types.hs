--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022

module Types where
import Data.Text (intersperse, pack, unpack)
import Data.List (nub)

-- Representation of the right linear grammar RLG G = (N,Sigma,P,S), where rules are list of tupples where one tupple represents one rule for example A -> aC
data RLG = RLG {nonterminals :: [Char], terminals :: [Char], rules :: [(Char,[Char])], startingSymbol :: Char}

removeDuplicatesFromRLG :: RLG -> RLG
removeDuplicatesFromRLG (RLG n t r s) =  RLG {nonterminals = nub n, terminals = nub t, rules = nub r, startingSymbol = s}

-- Printing RLG to the standard output
showRLG :: RLG -> IO()
showRLG (RLG n t r s) = do
    putStrLn (unpack (intersperse ',' (pack n)))
    putStrLn (unpack (intersperse ',' (pack t)))
    putStrLn [s]
    --putStrLn r
    

-- Representation of nondeterministic finite automaton NFA M = (Q, Sigma, Delta, q0, F), delta is d: Q x Sigma -> 2^Q (implemented as (1,x,2))
data NFA = NFA {states :: [Char], alphabet :: [Char], delta :: (Char,Char,Char), finalStates :: [Char]}
    deriving (Show)

--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022

module Types where
import Data.Text (intersperse, pack, unpack)
import Data.List (nub)



-- Representation of the right linear grammar RLG G = (N,Sigma,P,S), where rules are list of tupples where one tupple represents one rule for example A -> aC.
data RLG = RLG {nonterminals :: [Char], terminals :: [Char], rules :: [(Char,[Char])], startingSymbol :: Char}

-- Nonterminals etc. are sets, not lists in Theoretical CS, this function removes duplicates - "making" a set out of list
removeDuplicatesFromRLG :: RLG -> RLG
removeDuplicatesFromRLG (RLG n t r s) =  RLG {nonterminals = nub n, terminals = nub t, rules = nub r, startingSymbol = s}

-- Formats string and splits it by ','
printElem :: [Char] -> [Char]
printElem e = init $ unpack (intersperse ',' (pack e))

-- Returns all rules in the form 'A->aB' each on its own line.
printRules :: [(Char,[Char])] -> String
printRules [] = ""
printRules [rule] = splitOneRule rule
printRules (rule:remRules) = splitOneRule rule ++ "\n" ++ printRules remRules

-- Process one rule and format it into a string
splitOneRule :: (Char,[Char]) -> String
splitOneRule rule =  [fst rule] ++ "->" ++ snd rule

-- Printing RLG to the standard output
showRLG :: RLG -> IO()
showRLG (RLG n t r s) = do
    putStrLn $ printElem n
    putStrLn $ printElem t
    putStrLn [s]
    putStrLn $ printRules r
    
-- Representation of nondeterministic finite automaton NFA M = (Q, Sigma, Delta, q0, F), delta is d: Q x Sigma -> 2^Q (implemented as (1,x,2))
data NFA = NFA {states :: [Char], alphabet :: [Char], delta :: (Char,Char,Char), finalStates :: [Char]}
    deriving (Show)

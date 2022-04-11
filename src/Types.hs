--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022
{-# LANGUAGE RecordWildCards #-}

module Types where

import Data.List (intercalate, nub)
import Data.Set (Set, toList)

data Rule = Rule {fromNonterm :: String, toSymbols :: String}
  deriving (Eq, Ord)

instance Show Rule where
  show Rule {..} = intercalate "->" [fromNonterm, toSymbols]

-- Representation of the right linear grammar RLG G = (N,Sigma,P,S)
data RLG = RLG {nonterminals :: [String], terminals :: [String], startingSymbol :: Char, rules :: Set Rule}

instance Show RLG where
  show RLG {..} =
    unlines $
      [intercalate "," nonterminals] ++ [intercalate "," terminals] ++ [[startingSymbol]] ++ map show (toList rules)

-- Removes duplicate terminals and nonterminals from RLG
removeDuplicatesFromRLG :: RLG -> RLG
removeDuplicatesFromRLG (RLG n t s r) = RLG {nonterminals = nub n, terminals = nub t, startingSymbol = s, rules = r}

-- Representation of nondeterministic finite automaton NFA M = (Q, Sigma, Delta, q0, F), delta is d: Q x Sigma -> 2^Q (implemented as (1,x,2))
data NFA = NFA {states :: [Char], alphabet :: [Char], delta :: (Char, Char, Char), finalStates :: [Char]}
  deriving (Show)

--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022

module Main where

import Parser ( crunchRLG, wrongArgs )
import Types ()
import System.Environment ( getArgs )   
import System.Directory ()  
import System.IO ()  
import Data.List ()  
import Control.Exception (TypeError)



-- The main driver code
main :: IO ()
main = do  
    (command:args) <- getArgs  
    parseCmdLineArgs command args

-- UDĚLAT ROZHODOVACÍ VĚTEV UŽ TADY, KTERÁ ROZHODNE, ZDA ČTU STDIN NEBO FILE

-- Parse command line arguments and decide, which branch of the program to take.
parseCmdLineArgs :: String -> [String] -> IO ()
parseCmdLineArgs com args 
    | com == "-i" = printRLG args -- Nejdřív vemu všechny args a pošlu je do printRLG, který si s tim poradí
    | com == "-1" = printTransformedRLG args
    | com == "-2" = printNFA args 
    | otherwise   = wrongArgs 

printRLG ::  [String] -> IO ()
printRLG args = do crunchRLG args


printTransformedRLG ::  [String] -> IO ()
printTransformedRLG filename = putStrLn ("-1")

printNFA ::  [String] -> IO ()
printNFA filename = putStrLn ("-2")
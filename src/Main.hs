--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022

module Main where

import Parser ()
import Types ()
import System.Environment ( getArgs )   
import System.Directory ()  
import System.IO ()  
import Data.List ()  



-- The main driver code
main :: IO ()
main = do  
    (command:filename:args) <- getArgs  
    parseCmdLineArgs command filename

-- Parse command line arguments and decide, which branch of the program to take.
parseCmdLineArgs :: String -> String -> IO ()
parseCmdLineArgs com fil 
    | com == "-i" = printRLG fil     
    | com == "-1" = printTransformedRLG fil
    | com == "-2" = printNFA fil
    | otherwise   = putStrLn "Input the arguments in format: -i [input_file] | -1 [input_file] | -2 [input_file]"

printRLG :: String -> IO ()
printRLG filename = do putStrLn ("-i" ++ filename)

printTransformedRLG :: String -> IO ()
printTransformedRLG filename = putStrLn ("-1" ++ filename)

printNFA :: String -> IO ()
printNFA filename = putStrLn ("-2" ++ filename)
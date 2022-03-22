{-# LANGUAGE ScopedTypeVariables #-}
module Main where

import Parser (test)
import Data.Char ( isSpace )
import System.Environment ( getArgs )   
import System.Directory ()  
import System.IO ()  
import Data.List ()  

main :: IO ()
main = do  
    (command:filename:args) <- getArgs  
    parseCmdLineArgs command filename

-- Parse command line arguments and decide, which branch of the program to take.
parseCmdLineArgs :: String -> String -> IO ()
parseCmdLineArgs com fil 
    | com == "-i" = printRLG fil     
    | com == "-1" = printTransformedRLG fil
    | com == "-2" = printDFA fil
    | otherwise   = putStrLn "Input the arguments in format: -i [input_file] | -1 [input_file] | -2 [input_file]"

printRLG :: String -> IO ()
printRLG filename = putStrLn ("-i" ++ filename)

printTransformedRLG :: String -> IO ()
printTransformedRLG filename = putStrLn ("-1" ++ filename)

printDFA :: String -> IO ()
printDFA filename = putStrLn ("-2" ++ filename)
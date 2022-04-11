--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022
module Main where

import Data.List ()
import Parser
import System.Directory ()
import System.Environment (getArgs)
import System.Exit (die)
import System.IO ()
import Types (RLG)

-- The main driver code
main :: IO ()
main = do
  (action, input) <- parseCmdLineArgs =<< getArgs
  either die action (parseRLG input)

-- Parse command line arguments and decide, which branch of the program to take.
parseCmdLineArgs :: [String] -> IO (RLG -> IO (), String)
parseCmdLineArgs [x, y] = do
  input <- readFile y
  case x of
    "-i" -> return (printRLG, input)
    "-1" -> die "Not implemented."
    "-2" -> die "Not implemented."
    _ -> die ("Unknown option " ++ x)
parseCmdLineArgs _ = die "Give me two arguments: [-i|-1|-2] filename"

-- Print the loaded RLG from the inner representation
printRLG :: RLG -> IO ()
printRLG = print
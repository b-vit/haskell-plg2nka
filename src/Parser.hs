--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Parser where
import Types (RLG (RLG), showRLG)
import System.IO
import qualified Data.Text    as T
import qualified Data.Text.IO as T
import Data.Text (pack, unpack, Text, replace)

-- Error thrown on wrong arguments
wrongArgs :: t
wrongArgs = 
    error "Input the arguments in format: {-i | -1 | -2} [input_file | RLG on STDIN]"

-- Error thrown on wrong grammar format
wrongGrammarFormat :: t
wrongGrammarFormat =
    error "Input the grammar in format: \n Nonterminals \n Terminals \n Starting Symbol \n Production Rules \nfor example: \n A,B \n a,b \n A \n A->B\n B->A \n ... \n B->#"

-- Load RLG from the IO, if args are list with one element, it might be filename, otherwise parse standard input
crunchRLG ::  [String] -> IO ()
crunchRLG [] = wrongArgs
crunchRLG [file]  = do
        linesList <- fmap T.lines (T.readFile file)
        if length linesList < 4
            then wrongGrammarFormat
            else parseRLG linesList
crunchRLG args = parseSTDIN -- args

-- Parses RLG from STDIN if filename is not defined, expecting the form Nonterminals \n Terminals \n Starting Symbol \n Production Rules
parseSTDIN ::  IO ()
parseSTDIN = do
    contents <- getContents  
    putStr contents  

-- Parses one rule, gets first symbol, drops (->) and gets the rest
parseOneRule :: Text -> (Char,[Char])
parseOneRule rule = (head $ unpack rule, tail $ unpack $ replace (pack "->") (pack "") rule)

-- Removes commas from Text of symbols and then return them as a [Char] (list of chars - String)
parseSymbols :: Text -> [Char]
parseSymbols symbols = unpack $ replace (pack ",") (pack "") symbols

parseRLG :: [Text] -> IO ()
parseRLG [] = wrongArgs
parseRLG (nonterminals:terminals:startingSymbol:productionRules) = do
    let productionRulesParsed = map parseOneRule productionRules
    let test = RLG (parseSymbols nonterminals) (parseSymbols terminals)  productionRulesParsed (head $ unpack startingSymbol)
    showRLG test -- TODO if -i, just show it, if -1 then do "something" with it, if -2 then create and print the NFA

-- Checks, whether the right linear grammar has valid structure
isRLGValid :: IO() 
isRLGValid = putStrLn "eh"
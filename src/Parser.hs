{-# LANGUAGE RecordWildCards #-}
--    Project: plg-2-nka (English: rlg-2-nfa)
--    Author:  Vít Barták (xbarta47)
--    Year:    2022
{-# OPTIONS_GHC -Wno-incomplete-patterns #-}

module Parser where

import Control.Arrow (left)
import Control.Monad ((<=<))
import Data.Set (Set, fromList)
import Text.Parsec (alphaNum, char, endBy, eof, many1, newline, parse, satisfy, sepBy1, string, (<|>))
import Text.Parsec.String (Parser)
import Types (RLG (..), Rule (Rule, fromNonterm), removeDuplicatesFromRLG)

-- Parse the whole RLG and validate it
parseRLG :: String -> Either String RLG
parseRLG = validateRLG <=< left show . parse rlgParser ""

-- Parse the RLG
rlgParser :: Parser RLG
rlgParser =
  RLG <$> alfanumericsParser <* newline
    <*> alfanumericsParser <* newline
    <*> startingSymbolParser <* newline
    <*> rulesParser <* eof

-- Parse the symbols that are alphanumerics
alfanumericsParser :: Parser [[Char]]
alfanumericsParser = sepBy1 symbolsParser comma

-- Parse one symbol
symbolsParser :: Parser [Char]
symbolsParser = many1 alphaNum <|> endingSymbol

-- Parse starting symbol
startingSymbolParser :: Parser Char
startingSymbolParser = satisfy (`elem` ['A' .. 'Z'])

-- Parse rules that are each on its own line
rulesParser :: Parser (Set Rule)
rulesParser = fromList <$> endBy ruleParser newline

-- Parse one rule
ruleParser :: Parser Rule
ruleParser = Rule <$> symbolsParser <* arr <*> symbolsParser

comma :: Parser Char
comma = char ','

endingSymbol :: Parser String
endingSymbol = string "#"

arr :: Parser String
arr = string "->"

-- Validate the RLG
validateRLG :: RLG -> Either String RLG
validateRLG rlg@RLG {..} = if allOK then Right $ removeDuplicatesFromRLG rlg else Left "invalid RLG"
  where
    allOK =
      all ((`elem` nonterminals) . fromNonterm) rules
        && elem [startingSymbol] nonterminals
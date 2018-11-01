-- | The DesktopEntry lexer.
module My.DesktopEntry.Lexer
  ( desktopEntrylexer )
  where

import Control.Monad.Identity

import Data.Text

import Text.Parsec.Char
import Text.Parsec.Language (emptyDef)
import Text.Parsec.Token


-- | The language definition for Desktop files.
desktopEntryDef :: GenLanguageDef Text st Identity
desktopEntryDef = emptyDef { commentLine    = "#"
                           , nestedComments = False
                           , identStart     = alphaNum
                           , identLetter    = noneOf "="
                           , opStart        = opLetter desktopEntryDef
                           , opLetter       = char '=' }

-- | The lexical parser for Desktop files.
desktopEntrylexer :: GenTokenParser Text st Identity
desktopEntrylexer = makeTokenParser desktopEntryDef

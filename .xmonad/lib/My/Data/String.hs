-- | Utility functions on strings.
module My.Data.String
  ( strip
  , isFoldPrefixOf
  , isFoldInfixOf )
  where

import Data.Char (isSpace, toLower)
import Data.List (isInfixOf, isPrefixOf)

import My.Data.List (stripWith)


-- | Removes all space characters at the start and end of a string.
strip :: String -> String
strip = stripWith isSpace

-- | @'isFoldPrefixOf' needle haystack@ returns 'True' if the @haystack@ starts
--   with the @needle@. The search is done case insensitively.
isFoldPrefixOf :: String -> String -> Bool
isFoldPrefixOf n h = (map toLower n) `isPrefixOf` (map toLower h)

-- | @'isFoldInfixOf' needle haystack@ returns 'True' if the @needle@ is
-- contained in the @haystack@. The search is done case insensitively.
isFoldInfixOf :: String -> String -> Bool
isFoldInfixOf n h = (map toLower n) `isInfixOf` (map toLower h)

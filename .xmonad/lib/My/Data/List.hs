-- | Utility functions on lists.
module My.Data.List
  ( stripWith
  , cleanSort )
  where

import Data.List (dropWhile, dropWhileEnd, nub, sort)


-- | @'strip' p xs@ applies 'dropWhile' and 'dropWhileEnd' on @xs@ using
--   the predicate @p@.
stripWith :: (a -> Bool) -> [a] -> [a]
stripWith p = (dropWhile p) . (dropWhileEnd p)

-- | Sorts a list of elements removing duplicates and null values.
cleanSort :: (Foldable t, Ord (t a)) => [t a] -> [t a]
cleanSort = sort . nub . (filter (not . null))

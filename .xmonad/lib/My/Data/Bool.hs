-- | Utility functions to work with booleans.
module My.Data.Bool
  ( applyWhen
  , applyUnless )
  where

-- | @'applyWhen' condition f x@ returns @f x@ if the @condition@ is 'True'.
--   Otherwise, @x@ is returned.
applyWhen :: Bool -> (a -> a) -> a -> a
applyWhen c f = if c then f else id

-- | @'applyUnless' condition f x@ return @f x@ if the @condition@ is 'False'.
--   Otherwise, @x@ is returned.
applyUnless :: Bool -> (a -> a) -> a -> a
applyUnless c f = if c then id else f


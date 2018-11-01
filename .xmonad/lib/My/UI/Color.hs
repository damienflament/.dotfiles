-- | A color without transparency.
module My.UI.Color
  ( Color (..)
  , hexColorValue )
  where

import Data.Char (toUpper)
import Data.Word

import Numeric (showHex)


-- | The @'RGB' = (red,green,blue)@ type embeds the values for red, green and
--   blue components of a color.
data Color = RGB { redChannel :: Word16
                 , greenChannel :: Word16
                 , blueChannel :: Word16 }

-- | @'hexColorValue' rgb@ returns the hexadecimal value of a 'Color'.
hexColorValue :: Color -> String
hexColorValue RGB { redChannel = r
                  , greenChannel = g
                  , blueChannel = b } = "#" ++ hex r ++ hex g ++ hex b
  where
    hex :: Word16 -> String
    hex w = (map toUpper) . twoChars . showHex' $ w

    showHex' :: Word16 -> String
    showHex' w = showHex w ""

    twoChars :: String -> String
    twoChars []              = "00"
    twoChars (c : [])        = '0' : c : []
    twoChars cs@(_ :_ : [])  = cs
    twoChars (_ : cs)        = twoChars cs

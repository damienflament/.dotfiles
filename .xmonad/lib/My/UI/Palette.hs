-- | A 16 colors palette: 8 main colors and 8 bright colors.
module My.UI.Palette
  ( module My.UI.Color
  , Palette (..)
  , paletteResources )
where

import qualified Data.Map as M

import My.UI.Color


-- | The 'Palette' data type embeds the 'Color' values for the 16 colors of a
--   standard terminal palette.
data Palette = Palette  { black :: Color
                        , red :: Color
                        , green :: Color
                        , yellow :: Color
                        , blue :: Color
                        , magenta :: Color
                        , cyan :: Color
                        , white :: Color
                        , brightBlack :: Color
                        , brightRed :: Color
                        , brightGreen :: Color
                        , brightYellow :: Color
                        , brightBlue :: Color
                        , brightMagenta :: Color
                        , brightCyan :: Color
                        , brightWhite :: Color }

-- | @'paletteResources' palette@ returns a map of X resource keys and values
--   declaring colors values of the given 'Palette'.
paletteResources :: Palette -> M.Map String String
paletteResources p = M.map (\c -> hexColorValue . c $ p) resources
  where resources :: M.Map String (Palette -> Color)
        resources = M.fromList  [ ("*.color0",  black)
                                , ("*.color1",  red)
                                , ("*.color2",  green)
                                , ("*.color3",  yellow)
                                , ("*.color4",  blue)
                                , ("*.color5",  magenta)
                                , ("*.color6",  cyan)
                                , ("*.color7",  white)
                                , ("*.color8",  brightBlack)
                                , ("*.color9",  brightRed)
                                , ("*.color10", brightGreen)
                                , ("*.color11", brightYellow)
                                , ("*.color12", brightBlue)
                                , ("*.color13", brightMagenta)
                                , ("*.color14", brightCyan)
                                , ("*.color15", brightWhite) ]

-- | The Solarized dark theme.
module My.UI.Theme.Solarized
  ( module My.UI.Theme
  , solarizedTheme )
  where

import My.UI.Palette.Solarized
import My.UI.Theme


-- | 'solarizedTheme' returns the dark Solarized theme.
solarizedTheme :: Theme
solarizedTheme =
  Theme { palette = solarizedPalette
        , background = brightBlack
        , foreground = brightBlue
        , font = "xft:monospace:size=10"}

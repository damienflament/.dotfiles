-- | The Solarized dark palette.
module My.UI.Palette.Solarized
  ( module My.UI.Palette
  , solarizedPalette)
where

import My.UI.Palette


-- | 'solarizedPalette' returns the dark Solarized 'Palette'.
solarizedPalette :: Palette
solarizedPalette =
  Palette { black         = s_base02
          , red           = s_red
          , green         = s_green
          , yellow        = s_yellow
          , blue          = s_blue
          , magenta       = s_magenta
          , cyan          = s_cyan
          , white         = s_base2
          , brightBlack   = s_base03
          , brightRed     = s_orange
          , brightGreen   = s_base01
          , brightYellow  = s_base00
          , brightBlue    = s_base0
          , brightMagenta = s_violet
          , brightCyan    = s_base1
          , brightWhite   = s_base3 }
          where
            s_yellow  = RGB 181 137   0
            s_orange  = RGB 203  75  22
            s_red     = RGB 220  50  47
            s_magenta = RGB 211  54 130
            s_violet  = RGB 108 113 196
            s_blue    = RGB  38 139 210
            s_cyan    = RGB  42 161 152
            s_green   = RGB 133 153   0
            s_base03  = RGB   0  43  54
            s_base02  = RGB   7  54  66
            s_base01  = RGB  88 110 117
            s_base00  = RGB 101 123 131
            s_base0   = RGB 131 148 150
            s_base1   = RGB 147 161 161
            s_base2   = RGB 238 232 213
            s_base3   = RGB 253 246 227

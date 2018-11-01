{-# OPTIONS_GHC -fno-warn-missing-signatures #-}

-- | Custom Layouts configuration.
module My.Layouts (myLayouts) where

import XMonad
import XMonad.Layout.HintedGrid
import XMonad.Layout.NoBorders
import XMonad.Layout.Renamed
import XMonad.Layout.Spacing

-- | 'myLayouts' is the list of layouts.
myLayouts = renamed [Replace "Vertically tiled"] tiled
        ||| renamed [Replace "Horizontally tiled"] (Mirror tiled)
        ||| renamed [Replace "Grid"] grid
        ||| renamed [Replace "Fullscreen"] fullscreen
  where
    spacing = spacingRaw True (Border 6 6 6 6) False (Border 6 6 6 6) False
    tiled = let nmaster = 1
                ratio = 1/2
                delta = 1/100
                in spacing . smartBorders $ Tall nmaster delta ratio
    grid = spacing . smartBorders $ Grid False
    fullscreen = noBorders Full

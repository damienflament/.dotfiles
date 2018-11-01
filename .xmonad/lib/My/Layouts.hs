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
    tiled = let nmaster = 1
                ratio = 1/2
                delta = 1/100
                in smartSpacing 6 . smartBorders $ Tall nmaster delta ratio
    grid = smartSpacing 6 . smartBorders $ Grid False
    fullscreen = noBorders Full

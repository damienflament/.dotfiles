-- | Custom windows management configuration.
module My.WindowsManagement ( myWindowsManagement) where

import XMonad
import XMonad.Hooks.ManageHelpers


-- | 'myWindowsManagement' is the 'ManageHook'.
myWindowsManagement :: ManageHook
myWindowsManagement = composeAll  [ isDialog --> doCenterFloat
                                  , isFullscreen --> doFullFloat
                                  , className =? "Xmessage" --> doCenterFloat ]


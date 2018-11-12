-- | The main XMonad configuration file.

import Control.Exception
import Control.Exception.Enclosed

import My.KeyBindings
import My.Layouts
import My.MouseBindings
import My.UI.Palette.Solarized
import My.UI.Theme.Solarized
import My.WindowsManagement

import System.IO

import XMonad
import XMonad.Hooks.EwmhDesktops
import XMonad.Hooks.DynamicLog
import XMonad.Hooks.ManageDocks
import XMonad.Util.Run

statusBarHandle :: IO Handle
statusBarHandle = spawnPipe $
        "xmobar"
    ++ " --bgcolor="
    ++ (hexColorValue . brightBlack $ solarizedPalette)
    ++ " --fgcolor="
    ++ (hexColorValue . brightBlue $ solarizedPalette)
    ++ " --font 'xft:ui:size=10' "
    ++ " --top"
    ++ " ~/.xmonad/xmobar.hs"

myStatusBar :: Handle -> X ()
myStatusBar h = dynamicLogWithPP xmobarPP
    { ppOutput = hPutStrLn h . pad
    , ppHidden = xmobarColor
                    (hexColorValue . brightGreen $ solarizedPalette)
                    (hexColorValue . green $ solarizedPalette)
                . pad
    , ppCurrent = xmobarColor
                    (hexColorValue . black $ solarizedPalette)
                    (hexColorValue . green $ solarizedPalette)
                . pad
    , ppLayout = xmobarColor
                    (hexColorValue . black $ solarizedPalette)
                    (hexColorValue . magenta $ solarizedPalette)
                . pad
    , ppTitle = xmobarColor
                (hexColorValue . black $ solarizedPalette)
                (hexColorValue . blue $ solarizedPalette)
                . pad
    , ppWsSep = ""
    , ppSep = " "
    }

_main :: IO ()
_main = do
    let t = solarizedTheme
    status <- statusBarHandle
    xmonad $ ewmh def
        { terminal    = "urxvt"
        , focusFollowsMouse = False
        , clickJustFocuses = False
        , modMask     = mod4Mask
        , keys = myKeyBindings
        , mouseBindings = myMouseBindings
        , normalBorderColor = hexColorValue . brightGreen $ solarizedPalette
        , focusedBorderColor = hexColorValue . green $ solarizedPalette
        , borderWidth = 2
        , workspaces = map show [ 1 .. 12 :: Integer ]
        , manageHook = manageDocks <+> myWindowsManagement
        , layoutHook = avoidStruts $ myLayouts
        , handleEventHook = docksEventHook
        , logHook = myStatusBar status
        , startupHook = applyTheme t
        }

exceptionHandler :: SomeException -> IO ()
exceptionHandler e = print e

main :: IO ()
main = _main `catchAny` exceptionHandler

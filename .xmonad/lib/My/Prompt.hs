-- | Custom prompt for "XMonad"
module My.Prompt
  ( module XMonad.Prompt
  , myXPConfig
  , myPrompt )
  where

import Control.Arrow

import Data.Default
import qualified Data.Map as M

import My.Prompt.Actions
import My.Prompt.Applications
import My.Prompt.Zsh
import My.UI.Palette
import My.UI.Theme
import My.UI.Theme.Solarized

import XMonad
import XMonad.Prompt
import qualified XMonad.StackSet as W


-- | Prompt using multiple modes : 'applicationsMode' and 'zshMode.
myPrompt :: X ()
myPrompt = do appsMode <- applicationsMode
              zMode <- zshMode
              mkXPromptWithModes [appsMode, zMode, actionsMode] myXPConfig

-- | Custom 'XPConfig'.
myXPConfig :: XPConfig
myXPConfig = def { XMonad.Prompt.font = My.UI.Theme.font solarizedTheme
                 , bgColor = hexColorValue . (background solarizedTheme) $ (palette solarizedTheme)
                 , fgColor = hexColorValue . (foreground solarizedTheme) $ (palette solarizedTheme)
                 , fgHLight = hexColorValue . (background solarizedTheme) $ (palette solarizedTheme)
                 , bgHLight = hexColorValue . (foreground solarizedTheme) $ (palette solarizedTheme)
                 , borderColor = hexColorValue . (foreground solarizedTheme) $ (palette solarizedTheme)
                 , position = Top
                 , alwaysHighlight = True
                 , height = 24
                 , promptKeymap = myPromptKeyBindings
                 , changeModeKey = xK_twosuperior}

myPromptKeyBindings :: M.Map (KeyMask, KeySym) (XP ())
myPromptKeyBindings = M.fromList $
  map (first $ (,) noModMask)
      [ (xK_Return, setSuccess True >> setDone True)
      , (xK_KP_Enter, setSuccess True >> setDone True)
      , (xK_BackSpace, deleteString Prev)
      , (xK_Delete, deleteString Next)
      , (xK_Left, moveCursor Prev)
      , (xK_Right, moveCursor Next)
      , (xK_Home, startOfLine)
      , (xK_End, endOfLine)
      , (xK_Down, moveHistory W.focusUp')
      , (xK_Up, moveHistory W.focusDown')
      , (xK_Escape, quit) ]

-- | Custom key bindings configuration.
module My.KeyBindings (myKeyBindings) where

import qualified Data.Map as M

import My.Core
--import My.Prompt
import My.Terminal

import System.Exit

import XMonad hiding (restart)
import qualified XMonad.StackSet as W
import XMonad.Util.Paste


-- | @'myKeyBindings' config key-action-map@ binds keys to 'X' actions using
--   given configuration.
myKeyBindings :: XConfig Layout -> M.Map (KeyMask, KeySym) (X ())
myKeyBindings (XConfig { modMask = m,
                         layoutHook = l,
                         workspaces = ws }) = M.fromList $
  [ ((m,                xK_Return), spawnTerminal)
  , ((m .|. shiftMask,  xK_Return), spawnSuperTerminal)
  --, ((m,                xK_e),      spawnCommandInTerminal "ranger")
  --, ((m .|. shiftMask,  xK_e),      spawnCommandInSuperTerminal "ranger")

  --, ((m,                xK_Escape),  myPrompt)

  --, ((m .|. mod1Mask,               xK_c),  spawn "autoclick --start")
  --, ((m .|. shiftMask .|. mod1Mask, xK_c),  spawn "autoclick --stop")

  , ((m,                xK_v), pasteSelection)

  , ((m,                xK_w), kill)

  , ((m,                xK_l), sendMessage NextLayout)
  , ((m .|. shiftMask,  xK_l), setLayout l)

  , ((m,                xK_Down), windows W.focusDown)
  , ((m,                xK_Up),   windows W.focusUp)
  , ((m,                xK_m),    windows W.focusMaster)
  , ((m .|. shiftMask,  xK_Down), windows W.swapDown)
  , ((m .|. shiftMask,  xK_Up),   windows W.swapUp)
  , ((m .|. shiftMask,  xK_m),    windows W.swapMaster)

  , ((m,                xK_t), withFocused $ windows . W.sink)

  , ((m,                xK_Left),   sendMessage Shrink)
  , ((m,                xK_Right),  sendMessage Expand)


  , ((m,                xK_r),  restart True)
  , ((m .|. shiftMask,  xK_q), io (exitWith ExitSuccess)) ]

  ++

  [ ((m .|. m2, k), windows $ f i)
      -- switch to workspace
      | (i, k)  <- zip ws [xK_F1 .. xK_F12]
      -- move client to worskpace
      , (f, m2) <- [ (W.greedyView, 0), (W.shift, shiftMask) ] ]

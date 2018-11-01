-- | Custom mouse bindings configuration.
module My.MouseBindings (myMouseBindings) where

import qualified Data.Map as M

import XMonad
import qualified XMonad.StackSet as W


-- | @'myMouseBindings' config button-action-map@ binds mouse buttons to
--   'X' actions using given configuration.
myMouseBindings :: XConfig a -> M.Map (KeyMask, Button) (Window -> X ())
myMouseBindings XConfig { modMask = m } = M.fromList $
    [ ((m, button1), (\w -> do  focus w
                                mouseMoveWindow w
                                windows W.shiftMaster))
    , ((m, button3), (\w -> do  focus w
                                mouseResizeWindow w
                                windows W.shiftMaster)) ]

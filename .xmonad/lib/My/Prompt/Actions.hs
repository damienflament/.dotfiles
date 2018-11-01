-- | X actions prompt.
module My.Prompt.Actions ( actionsMode ) where

import Data.List (find, sortOn)

import My.Core
import My.Data.Bool (applyUnless)
import My.Data.String (isFoldInfixOf)

import XMonad hiding (recompile, restart)
import XMonad.Prompt


data Actions = Actions [(String, X())]

instance XPrompt Actions where
  showXPrompt _ = "XMonad: "

  commandToComplete _ = id

  completionFunction (Actions cs) s = return $
    applyUnless (null s)
                (filter (isFoldInfixOf s))
                (map fst cs)

  modeAction (Actions cs) _ n =
    maybe (return ()) -- ignores error
    snd
    (find ((==) n . fst) cs)

-- | The X actions prompt mode.
actionsMode :: XPMode
actionsMode = XPT (Actions (sortOn fst commands))

commands :: [(String,X())]
commands = [ ("Compile",             compile False)
                   , ("Compile everything",  compile True)
                   , ("Restart",             restart True)
                   , ("Clean and Restart",   restart False)
                   , ("Compile and restart", compile False >> restart True) ]

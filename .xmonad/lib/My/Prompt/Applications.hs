-- | An applications prompt for XMonad.
module My.Prompt.Applications (applicationsMode) where

import Control.Monad (filterM)

import Data.List (find)
import qualified Data.Text as Text (unpack)

import My.Data.Bool (applyUnless)
import My.Data.String (isFoldInfixOf)
import My.DesktopEntry
import My.DesktopFile
import My.Terminal

import System.Directory (withCurrentDirectory)

import XMonad
import XMonad.Prompt


data Applications = Applications [DesktopEntry]

instance XPrompt Applications where
  showXPrompt (Applications es) = (show (length es)) ++ " applications: "

  commandToComplete _ = id

  completionFunction (Applications es) s = return $
    applyUnless (null s)
                (filter (isFoldInfixOf s))
                (map (Text.unpack . name) es)

  modeAction (Applications es) _ n =
    maybe (return ()) -- ignores error
          spawnApplication
          (find ((==) n . Text.unpack . name) es)

-- | The applications prompt mode.
applicationsMode :: X XPMode
applicationsMode = do entries <- io applicationEntries
                      return $ XPT (Applications entries)
  where
    applicationEntries :: IO [DesktopEntry]
    applicationEntries = desktopFiles
                     >>= parseDesktopFiles
                     >>= filterM shouldBeShown
                     >>= return . uniqSort

-- @'spawnApplication' entry@ spawns the application described by the given
-- 'DesktopEntry'.
spawnApplication :: DesktopEntry -> X ()
spawnApplication DesktopEntry { exec = c,
                                inTerminal = t,
                                path = p } =
  if t then spawnCommandInTerminal c else spawn c

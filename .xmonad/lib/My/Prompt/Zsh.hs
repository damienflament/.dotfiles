-- | A Zsh prompt fox "XMonad".
module My.Prompt.Zsh ( zshMode ) where

import My.Data.List (cleanSort)
import My.Data.String (isFoldPrefixOf)
import My.Terminal (spawnCommandInTerminal)

import System.Directory (listDirectory)
import System.FilePath (getSearchPath)

import XMonad
import XMonad.Prompt


data Zsh = Zsh [FilePath]

instance XPrompt Zsh where
  showXPrompt _ = "zsh > "

  commandToComplete _ = id

  completionFunction (Zsh bs) s = return $
    if null s
      then []
      else filter (isFoldPrefixOf s) bs

  modeAction _ c _ = spawnCommandInTerminal c

-- | The Zsh prompt mode.
zshMode :: X XPMode
zshMode = do binaries <- io listBinaries
             return $ XPT (Zsh binaries)
  where
    listBinaries :: IO [FilePath]
    listBinaries = getSearchPath
               >>= mapM listDirectory
               >>= return . cleanSort . concat

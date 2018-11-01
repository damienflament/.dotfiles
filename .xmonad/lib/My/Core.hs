-- | Additions to "XMonad.Core".
module My.Core
    ( compile
    , restart)
    where

import Control.Exception
import Control.Monad

import System.Directory
import System.FilePath
import System.Info
import System.Process

import XMonad hiding (restart)
import qualified XMonad.Operations (restart)


-- | @'compile' force@ compiles XMonad configuration. If @force@ is @True@,
--   the build cache directory is cleared before compilation.
--
-- XDG base directories are used to store compilation cache.
compile :: MonadIO m => Bool -> m ()
compile force = io $ do
  dir <- getXMonadDir
  cache <- getXdgDirectory XdgCache "xmonad"

  let target = dir </> "xmonad-" ++ arch ++ "-" ++ os

  when force (removeDirectoryRecursive cache)

  uninstallSignalHandlers

  callProcess "ghc" [ "--make", main
                    , "-o", target
                    , "-i", "-i" ++ lib
                    , "-odir", cache
                    , "-hidir", cache
                    , "-Wall"
                    , "-fwarn-tabs"
                    , "-fwarn-incomplete-uni-patterns"
                    , "-fwarn-incomplete-record-updates"
                    , "-fwarn-unrecognised-pragmas"
                    , "-O"
                    , "-j4"
                    , "-threaded" ]
  `finally` installSignalHandlers


  where main = "/local/src/xmonad/xmonad.hs"
        lib = "/local/src/haskell"

-- | @'restart' resume@ restarts XMonad. If resume is @True@, the current
--   windows state is keeped.
restart :: Bool -> X ()
restart = XMonad.Operations.restart "xmonad"

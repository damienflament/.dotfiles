-- | A module for spawning terminals.
module My.Terminal
  ( spawnTerminal
  , spawnCommandInTerminal
  , spawnSuperTerminal
  , spawnCommandInSuperTerminal )
  where

import XMonad hiding (spawn, terminal)
import qualified XMonad as XMonad (spawn, terminal)


-- | 'spawnTerminal' spawns a terminal.
spawnTerminal :: X ()
spawnTerminal = terminal >>= XMonad.spawn

-- | 'spawnSuperTerminal' spawns a terminal as a super user.
spawnSuperTerminal :: X ()
spawnSuperTerminal = spawnCommandInSuperTerminal "-s"

-- | @'spawnCommandInTerminal' command@ spawns a terminal executing a @command@.
spawnCommandInTerminal :: String -> X ()
spawnCommandInTerminal c = terminal
                       >>= XMonad.spawn
                         . command
                         . (flip (:) ["-e", c])

-- | @'spawnCommandInSuperTerminal' command@ spawns a terminal executing a
--   @command@ as a super user.
spawnCommandInSuperTerminal :: String -> X ()
spawnCommandInSuperTerminal c = terminal
                            >>= XMonad.spawn
                              . command
                              . (flip (:) ["-e", "sudo", "-E ", c])

-- 'terminal' returns the terminal command given by the 'XConfig'.
terminal :: X (String)
terminal = asks config >>= return . XMonad.terminal

-- @'command' elements@ makes a command from the given @elements@.
command :: [String] -> String
command [] = []
command (e:es) = e ++ " " ++ command es

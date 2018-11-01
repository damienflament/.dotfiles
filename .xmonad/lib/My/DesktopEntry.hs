-- | A type embedding DesktopEntry data for Applications.
module My.DesktopEntry
  ( DesktopEntry (..)
  , emptyDesktopEntry
  , shouldBeShown
  , expandCommand )
  where

import Data.Maybe
import Data.Text (Text, empty)

import My.Data.String

import System.Directory


-- | The data type 'DesktopEntryT' represents the content of the /Desktop Entry/
--   group in a Desktop file.
data DesktopEntry = DesktopEntry { name :: Text
                                 , genericName :: Maybe Text
                                 , comment :: Maybe Text
                                 , tryExec :: Maybe FilePath
                                 , exec :: String
                                 , path :: Maybe FilePath
                                 , inTerminal :: Bool
                                 , categories :: [String]
                                 , noDisplay :: Bool }
  deriving Show

instance Eq DesktopEntry where
  (==) x y = (name x) == (name y)

instance Ord DesktopEntry where
  compare x y = compare (name x) (name y)

-- | 'emptyDesktopEntry' helps to make a 'DesktopEntry' in multiple steps,
--   passing an invalid record to many consecutive functions.
--
-- Values set for mandatory values ('name' and 'exec') are not supposed to
-- remain empty.
emptyDesktopEntry :: DesktopEntry
emptyDesktopEntry = DesktopEntry { name = empty
                                 , genericName = Nothing
                                 , comment = Nothing
                                 , tryExec = Nothing
                                 , exec = []
                                 , path = Nothing
                                 , inTerminal = False
                                 , categories = []
                                 , noDisplay = False }

-- | @'shouldBeShown' entry@ returns 'True' if the given 'DesktopEntry' should
--   be shown in the menus.
shouldBeShown :: DesktopEntry -> IO Bool
shouldBeShown DesktopEntry { noDisplay = nodisplay
                           , tryExec = tryexec} = do
  if nodisplay
    then return False
    else if isNothing tryexec
           then return True
           else do execPath <- findExecutable $ fromJust tryexec
                   return $ isJust execPath

-- | @'expandCommand' command@ expands field codes.
--
-- Currently, field codes are not used. They are simply ignored.
expandCommand :: String -> String
expandCommand = strip . expandCommand'
  where
    expandCommand' :: String -> String
    expandCommand' []           = []
    expandCommand' ('%':[])     = []
    expandCommand' ('%':'%':cs) = '%':expandCommand' cs
    expandCommand' ('%':_:cs)   = expandCommand' cs
    expandCommand' (c:cs)       = c:expandCommand' cs

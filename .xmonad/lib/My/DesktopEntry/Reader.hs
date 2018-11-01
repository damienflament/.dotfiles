-- | The 'DesktopEntry' reader.
module My.DesktopEntry.Reader ( readDesktopEntry ) where

import Data.Maybe
import Data.Text (Text)
import qualified Data.Text as Text

import My.DesktopEntry
import My.DesktopEntry.Parser

import Text.Parsec


-- | @'readDesktopEntry' text@ reads @text@ read from a Desktop file and
--   returns a @'Just' 'DesktopEntry'@. If an error occurs while parsing,
--   or no /Desktop Entry/ group is present, @'Nothing'@ is returned.
readDesktopEntry :: Text -> Maybe DesktopEntry
readDesktopEntry input = either (const Nothing) -- ignores error message
                                (\gs -> maybe Nothing
                                              (Just . makeDesktopEntry)
                                              (lookup "Desktop Entry" gs))
                                (parse desktopEntryParser "(unknown)" input)

-- @'makeDesktopEntry' key-value-list@ returns a 'DesktopEntry' filled with
-- data from the @key-value-list@.
makeDesktopEntry :: [KeyValue] -> DesktopEntry
makeDesktopEntry kvs = emptyDesktopEntry
  { name        = lookupMandatory  "Name"
  , genericName = lookupOptional "GenericName"
  , comment     = lookupOptional "Comment"
  , tryExec     = lookupOptionalString "TryExec"
  , exec        = do expandCommand $ lookupMandatoryString "Exec"
  , path        = lookupOptionalString "Path"
  , inTerminal  = lookupBoolean "Terminal"
  , categories  = lookupList "Categories"
  , noDisplay   = lookupBoolean "NoDisplay" }
  where
    lookupOptional :: String -> Maybe Text
    lookupOptional n = lookup n kvs

    lookupMandatory :: String -> Text
    lookupMandatory = fromJust . lookupOptional

    lookupOptionalString :: String -> Maybe String
    lookupOptionalString n = maybe Nothing
                                   (Just . readStringValue)
                                   (lookup n kvs)

    lookupMandatoryString :: String -> String
    lookupMandatoryString = fromJust . lookupOptionalString

    lookupBoolean :: String -> Bool
    lookupBoolean n = maybe False
                            readBoolValue
                            (lookup n kvs)

    lookupList :: String -> [String]
    lookupList n = maybe []
                         readListValue
                         (lookup n kvs)

-- @'readStringValue text' reads a 'DesktopEntry' ASCII value.
readStringValue :: Text -> String
readStringValue = Text.unpack

-- @'readBoolValue text' reads a 'DesktopEntry' boolean value.
readBoolValue :: Text -> Bool
readBoolValue t | (Text.unpack t) == "true" = True
                | otherwise                 = False

-- @'readListValue text' reads a 'DesktopEntry' list value.
readListValue :: Text -> [String]
readListValue t | Text.null t = []
                | otherwise   = map (Text.unpack)
                                    (filter (not . Text.null)
                                            (Text.splitOn (Text.pack ";") t))

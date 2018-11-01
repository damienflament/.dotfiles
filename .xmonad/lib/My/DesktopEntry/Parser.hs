-- | A parser for Desktop files.
module My.DesktopEntry.Parser
  ( desktopEntryParser
  , Group
  , GroupName
  , KeyValue
  , Key
  , Value )
  where

import Data.Text (Text)
import qualified Data.Text as Text

import My.DesktopEntry.Lexer

import Text.Parsec
import Text.Parsec.Text
import qualified Text.Parsec.Token as P


-- | A 'Group' contains a list of 'KeyValue' pairs labeled by a group name.
type Group = (GroupName, [KeyValue])

-- | A 'GroupName' is an ASCII string.
--
-- @[@, @]@ and control characters are forbidden.
type GroupName = String

-- | 'KeyValue' pair is a tuple containing a key and its value.
type KeyValue = (Key,Value)

-- | A 'Key' is an ASCII string .
--
-- Only latin letters, digits and the @-@ character are allowed.
type Key = String

-- | A 'Value' is an unicode string.
type Value = Text

-- | A 'GenParser' which generates a list of 'Group'.
desktopEntryParser :: GenParser st [Group]
desktopEntryParser = do whiteSpace
                        gs <- many group
                        eof
                        return gs

group :: GenParser st Group
group = do h <- header
           kvs <- many1 keyValue
           return (h,kvs)

keyValue :: GenParser st KeyValue
keyValue = do k <- key
              operator
              v <- value
              return (k,v)

key :: GenParser st Key
key = P.identifier desktopEntrylexer

value :: GenParser st Value
value = do v <- lexeme . many $ noneOf "\r\n"
           return $ Text.pack v

header :: GenParser st GroupName
header = brackets groupName

groupName :: GenParser st GroupName
groupName = lexeme . many1 $ noneOf "]"

operator :: GenParser st ()
operator = do _ <- P.operator desktopEntrylexer
              return ()

brackets :: GenParser st a -> GenParser st a
brackets = P.brackets desktopEntrylexer

whiteSpace :: GenParser st ()
whiteSpace = P.whiteSpace desktopEntrylexer

lexeme :: GenParser st a -> GenParser st a
lexeme = P.lexeme desktopEntrylexer

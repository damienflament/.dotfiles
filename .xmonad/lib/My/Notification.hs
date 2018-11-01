module My.Notification
  ( Notification (..)
  , notification )
  where

import Data.Int (Int32)
import Data.Word (Word32)

import XMonad
-- import qualified XMonad.Util.ExtensibleState as XState


data NotificationIdentifier = NotificationIdentifier Word32
  deriving (Typeable,Read,Show)

instance ExtensionClass NotificationIdentifier where
  initialValue = NotificationIdentifier 1
  extensionType = PersistentExtension

data Notification = Notification { identifier      :: Word32
                                 , applicationName :: Maybe String
                                 , summary         :: String
                                 , body            :: Maybe String
                                 , icon            :: Maybe FilePath
                                 , timeout         :: Maybe Int32 }
  deriving Show

notification :: Word32
             -> String
             -> String
             -> String
             -> FilePath
             -> Int32
             -> Notification
notification replacesId n s b i t =
  Notification { identifier      = replacesId
               , applicationName = optionalString n
               , summary         = s
               , body            = optionalString b
               , icon            = optionalString i
               , timeout         = optionalInt t }
    where
      optionalString :: String -> Maybe String
      optionalString [] = Nothing
      optionalString xs = Just xs

      optionalInt :: Int32 -> Maybe Int32
      optionalInt (-1) = Nothing
      optionalInt x    = Just x



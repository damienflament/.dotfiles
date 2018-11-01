{-# LANGUAGE OverloadedStrings #-}
module My.NotificationServer
  ( notificationServer )
  where

import Data.Int (Int32)
import Data.Map (Map)
import Data.Word (Word32)

import DBus
import DBus.Client

import My.Notification


notificationServer :: IO ()
notificationServer = do
  client <- connectSession
  reply <- requestName client busName
             [ nameAllowReplacement
             , nameReplaceExisting
             , nameDoNotQueue ]

  case reply of
    NamePrimaryOwner -> export client objectPath
      [ autoMethod' "GetCapabilities" getCapabilities
      , autoMethod' "Notify" notify
      , autoMethod' "GetServerInformation" getServerInformation ]
    NameInQueue      -> print $ "NotificationServer waiting for "
                          ++ formatBusName busName
    NameExists       -> print $ "NotificationServer failed reserving "
                          ++ formatBusName busName
    NameAlreadyOwner -> print $ "NotificationServer already owner of "
                          ++ formatBusName busName
    _                -> print $ "Unknown reply when requesting ownership for "
                          ++ formatBusName busName

  where
    busName :: BusName
    busName = "org.freedesktop.Notifications"

    objectPath :: ObjectPath
    objectPath = "/org/freedesktop/Notifications"

    interfaceName :: InterfaceName
    interfaceName = "org.freedesktop.Notifications"

    autoMethod' :: AutoMethod f => MemberName -> f -> Method
    autoMethod' = autoMethod interfaceName

getCapabilities :: IO [String]
getCapabilities = return []

notify :: String             -- app_name
       -> Word32             -- replaces_id
       -> String             -- app_icon
       -> String             -- summary
       -> String             -- body
       -> [String]           -- actions
       -> Map String Variant -- hints
       -> Int32              -- expire_timeout
       -> IO Word32

notify n replacesId i s b _ _ t = do
  let x = notification replacesId n s b i t
  print x
  return $ identifier x

{- closeNotification :: ()
closeNotification = () -}

getServerInformation :: IO (String,String,String,String)
getServerInformation = return ( "Notification Server"
                              , "XMonad"
                              , "0.1"
                              , "1.2")



-- | A theme.
module My.UI.Theme
  ( Theme (..)
  , applyTheme )
  where

import My.UI.Palette

import XMonad hiding (Color)
import XMonad.Util.Cursor
import XMonad.Util.XUtils

import qualified Data.Map as M


-- | A 'Theme' embeds a 'Palette', a font and some contextual colors.
data Theme = Theme { palette :: Palette
                   , background :: Palette -> Color
                   , foreground :: Palette -> Color
                   , font :: String }

-- | @'applyTheme' theme@ applies a theme to the environment.
applyTheme :: Theme -> X ()
applyTheme t@(Theme { palette = p
                    , font = f }) = do
  withDisplay . setupResources $ (paletteResources p) `M.union` resources
                                                      `M.union` (themeResources t)
  withDisplay . setupBackground $ t
  setDefaultCursor xC_left_ptr
  where
    resources :: M.Map String String
    resources = M.fromList  [ ("*.scrollstyle", "plain")
                                , ("*.thickness",   "2")
                                , ("*.cursorBlink", "True")
                                , ("URxvt.font", f)]

-- @'themeResources' theme@ returns a map of X resource keys and values
-- declaring colors values of the given 'Palette'.
themeResources :: Theme -> M.Map String String
themeResources t@(Theme { palette = p }) = M.map
                                            (\s -> hexColorValue . (s t) $ p)
                                            resources
  where
    resources :: M.Map String (Theme -> (Palette -> Color))
    resources = M.fromList  [ ("*.background", background)
                            , ("*.foreground", foreground)
                            , ("*.cursorColor", foreground) ]

-- @'setupResources resources-map display'@ applies the given resources
-- to the given 'Display'.
setupResources :: M.Map String String -> Display -> X ()
setupResources rs dpy = io $ setTextProperty dpy w txt rESOURCE_MANAGER
  where
    w :: Window
    w = defaultRootWindow dpy

    txt :: String
    txt = M.foldrWithKey (\ r v acc -> acc ++ r ++ ": " ++ v ++ "\n")
                         ""
                         rs

-- @'setupBackground' theme display@ applies the background specified in the
-- given 'Theme' to the given 'Display'.
setupBackground :: Theme -> Display -> X()
setupBackground (Theme { palette = p
                       , background = b }) dpy =
  io $ do px <- stringToPixel dpy (hexColorValue . b $ p)
          setWindowBackground dpy w px
          clearWindow dpy w
          sync dpy False
    where w :: Window
          w = defaultRootWindow dpy



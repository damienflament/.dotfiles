-- | Parse Desktop files.
module My.DesktopFile
  ( desktopFiles,
    parseDesktopFile,
    parseDesktopFiles)
  where

import qualified Data.Text.IO as Text (readFile)

import My.DesktopEntry
import My.DesktopEntry.Reader

import System.Directory


-- | 'desktopFiles' returned the list of Desktop filepaths located in the
--   system.
desktopFiles :: IO [FilePath]
desktopFiles = do filenames <- listDirectory applicationsDirectory
                  withCurrentDirectory applicationsDirectory
                                       (mapM makeAbsolute filenames)
  where applicationsDirectory :: String
        applicationsDirectory = "/usr/share/applications"

-- | @'parseDesktopFile' filepath@ parses the file located by the @filepath@ and
--   includes the data in the returned 'DesktopEntry'.
parseDesktopFile :: FilePath -> IO (Maybe DesktopEntry)
parseDesktopFile f = do content <- Text.readFile f
                        return $ readDesktopEntry content

-- | @'parseDesktopFiles' filepaths@ parses the files located by the @filepaths@
--   and includes the data in the returned 'DesktopEntry' list.
parseDesktopFiles :: [FilePath] -> IO [DesktopEntry]
parseDesktopFiles []     = return []
parseDesktopFiles (f:fs) = do entry <- parseDesktopFile f
                              entries <- parseDesktopFiles fs
                              return $ maybe entries
                                             (flip (:) entries)
                                             entry

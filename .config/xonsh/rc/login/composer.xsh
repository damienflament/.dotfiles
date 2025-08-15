""" Composer. """

$COMPOSER_HOME = p"$XDG_CONFIG_HOME" / "composer"
$COMPOSER_CACHE_DIR = p"$XDG_CACHE_HOME" / "composer"
$COMPOSER_DATA_DIR = p"$XDG_DATA_HOME" / "composer"
$COMPOSER_VENDOR_DIR = p"$XDG_DATA_HOME" / "composer/vendor"
$COMPOSER_BIN_DIR = $HOME / ".local/bin"

$PATH.add($COMPOSER_BIN_DIR, front=True, replace=True)

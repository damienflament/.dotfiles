""" Compatibilité avec la spécification XDG Base Directory.

Certaines applications n'utilisent pas les répertoires XDG pour stocker leur
fichiers de configuration. Nous définissons explicitement leur localisation
afin de remédier à cela.

Ces variables sont censées rester définies même lorsque l'application
concernée est désinstallée.
"""

$CABAL_CONFIG = p"$XDG_CONFIG_HOME" / "cabal/config"
$CARGO_HOME = p"$XDG_CACHE_HOME" / "cargo"
$DIALOGRC = p"$XDG_CONFIG_HOME" / "dialog/dialogrc"
$ELINKS_CONFDIR = p"$XDG_CONFIG_HOME" / "elinks"
$GNUPGHOME = p"$XDG_DATA_HOME" / "gnupg"
$LESSHISTFILE = p"$XDG_CACHE_HOME" / "lesshst"
$PYLINTHOME = p"$XDG_CACHE_HOME" / "pylint"
$PYTEST_ADDOPTS="-o cache_dir=" + str(p"$XDG_CACHE_HOME" / "pytest")
$STACK_ROOT = p"$XDG_CONFIG_HOME" / "stack"
$UNISON = p"$XDG_CONFIG_HOME" / "unison"
$VIM_RC = p"$XDG_CONFIG_HOME" / "vim/vimrc"
$VIMPAGER_RC = p"$XDG_CONFIG_HOME" / "vim/vimpagerrc"

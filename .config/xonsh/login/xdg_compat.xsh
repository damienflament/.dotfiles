""" Compatibilité avec la spécification XDG Base Directory.

Certaines applications n'utilisent pas les répertoires XDG pour stocker leur
fichiers de configuration. Nous définissons explicitement leur  localisation
afin de remédier à cela.

Ces variables sont censées restées définies même lorsque l'application
concernée est désinstalée.
"""

$CABAL_CONFIG = p"$XDG_CONFIG_HOME/cabal/config"
$DIALOGRC = p"$XDG_CONFIG_HOME/dialog/dialogrc"
$ELINKS_CONFDIR = p"$XDG_CONFIG_HOME/elinks"
$LESSHISTFILE = p"$XDG_CACHE_HOME/lesshst"
$PYLINTHOME = p"$XDG_CACHE_HOME/pylint"
$STACK_ROOT = p"$XDG_CONFIG_HOME/stack"
$VIM_RC = p"$XDG_CONFIG_HOME/vim/vimrc"
$VIMPAGER_RC = p"$XDG_CONFIG_HOME/vim/vimpagerrc"

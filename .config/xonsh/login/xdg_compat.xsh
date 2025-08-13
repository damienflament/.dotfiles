""" XDG Base Directory specification compatibility.

Some applications don't use the XDG directories to store configuration files.
Set the configuration files location explicitly to fix that.

Those variables are meant to stay defined even when the related application is
not installed on the system.
"""

$CABAL_CONFIG = p"$XDG_CONFIG_HOME/cabal/config"
$DIALOGRC = p"$XDG_CONFIG_HOME/dialog/dialogrc"
$ELINKS_CONFDIR = p"$XDG_CONFIG_HOME/elinks"
$LESSHISTFILE = p"$XDG_CACHE_HOME/lesshst"
$PYLINTHOME = p"$XDG_CACHE_HOME/pylint"
$STACK_ROOT = p"$XDG_CONFIG_HOME/stack"
$VIM_RC = p"$XDG_CONFIG_HOME/vim/vimrc"
$VIMPAGER_RC = p"$XDG_CONFIG_HOME/vim/vimpagerrc"


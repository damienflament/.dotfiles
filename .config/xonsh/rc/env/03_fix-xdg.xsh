""" Répertoires utilisateurs XDG.

FIXME Les variables suivantes sont stockées en tant que chaîne de caractères.
Xonsh refuse de les stocker sous forme de Path.
"""

$XDG_CONFIG_HOME = $HOME / ".config"
$XDG_CACHE_HOME = $HOME / ".cache"
$XDG_DATA_HOME = $HOME / ".local/share"

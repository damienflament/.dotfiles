""" Historique des commandes. """

# Suppression des doublons.
$HISTCONTROL = {
    "ignoredups",
    "erasedups",
}

# Stockage de 1000 commandes.
$XONSH_HISTORY_SIZE = "10000 commands"

# Stockage avec SQLite.
$XONSH_HISTORY_BACKEND = "sqlite"

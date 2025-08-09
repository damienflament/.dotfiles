""" Shell history. """

# Don't store duplicates.
$HISTCONTROL = {
    "ignoredups",
    "erasedups",
}

# Store 10000 commands.
$XONSH_HISTORY_SIZE = "10000 commands"

# Use SQLite storage backend.
$XONSH_HISTORY_BACKEND = "sqlite"

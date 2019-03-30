# Shell interactive configuration #

autoload source_all

# Load configuration subfiles
source_all "$ZDOTDIR/interactive.d"/*(N)

# User commands are sourced functions
source_all "$XDG_DATA_HOME/zsh/commands"/*(N)

# vim: ft=zsh

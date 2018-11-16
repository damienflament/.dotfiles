# Shell environment #

# If not set, set ZDOTDIR to the directory containing this file
if [[ -z "$ZDOTDIR" ]]
then
    export ZDOTDIR=${(%):-%x:h}
fi

# Set XDG Base user directories paths
export XDG_CONFIG_HOME="$HOME/.config"
export XDG_CACHE_HOME="$HOME/.cache"
export XDG_DATA_HOME="$HOME/.local/share"

# Prevent duplicates within search paths
typeset -U fpath
typeset -U path

# Make user functions available
fpath=( "$XDG_DATA_HOME/zsh/functions" $fpath )

# Load environment subfiles
autoload source_all

source_all $ZDOTDIR/environment.d/*(N)

# vim: ft=zsh
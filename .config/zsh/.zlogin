# Shell login #

if [[ "$USERNAME" != 'root' && -z "$DISPLAY" ]]
then
    exec zdm
fi

# vim: ft=zsh

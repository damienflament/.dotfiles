""" Palette de couleur de la console Linux.

Définit la palette de couleur de la console Linux en utilisant `setcolors`.
"""
if $XONSH_INTERACTIVE:

    # TODO Vérifier que `setcolors` est disponible.
    if on_linux_console:
        setcolors p"$XDG_DATA_HOME/setcolors/solarized"

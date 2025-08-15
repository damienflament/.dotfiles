""" Palette de couleur de la console Linux.

Définit la palette de couleur de la console Linux en utilisant `setcolors`.
"""

from terminal import on_linux_console

# TODO Vérifier que `setcolors` est disponible.
if on_linux_console:
    setcolors @(p"$XDG_DATA_HOME" / "setcolors/solarized")

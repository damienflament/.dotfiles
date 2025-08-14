""" Coloration des listes de fichiers.

La sortie de `ls` est définie avec `dircolors`.
"""

if $XONSH_INTERACTIVE:

    dircolors_file = p"$XDG_DATA_HOME/dircolors/dir_colors"

    # TODO Vérifier que `dircolors` est disponible.
    if dircolors_file.is_file():
        source-bash $(dircolors --sh @(dircolors_file))

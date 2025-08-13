""" Files listing coloring.

Setups `ls` output coloring using `dircolors`.
"""

if $XONSH_INTERACTIVE:

    dircolors_file = p"$XDG_DATA_HOME/dircolors/dir_colors"

    # TODO: Check if `dircolors` is available.
    # if dircolors_file.is_file():
    #     source-bash $(dircolors --sh @(dircolors_file))

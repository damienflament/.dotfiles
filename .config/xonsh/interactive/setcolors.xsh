""" Linux console solor palette.

Setups the color palette of the Linux console using `setcolors`.
"""
if $XONSH_INTERACTIVE:

    # TODO: Check if `setcolors` is available
    if on_linux_console:
        setcolors p"$XDG_DATA_HOME/setcolors/solarized"

""" Linux console solor palette.

Setups the color palette of the Linux console using `setcolors`.
"""

# TODO: Check if `setcolors` is available
if $TERM == "linux":
    setcolors p"$XDG_DATA_HOME/setcolors/solarized"

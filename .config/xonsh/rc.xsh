""" Xonsh main configuration file.

This file is loaded before the splitted configuration files found in the
rc.d directory.
"""

# Update `os.environ` to match Xonsh environment.
$UPDATE_OS_ENVIRON = True

# TODO Put it in a xontrib.
on_linux_console = "TERM" in ${...} and $TERM == "linux"

# Maximum number of parallel processus
from multiprocessing import cpu_count

$NPROC = cpu_count()

del cpu_count


if $XONSH_LOGIN:

    # Source /etc/profile as sh
    # source-foreign /bin/sh /etc/profile # FIXME Broken ! See fix below !

    # Fixes https://github.com/xonsh/xonsh/issues/5894
    # Fixes https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile

    # Fixes https://github.com/xonsh/xonsh/issues/5870
    from xonsh.tools import EnvPath

    if not isinstance($PATH, EnvPath):
        $PATH = EnvPath($PATH)

    del EnvPath

    if "XONSH_VENV" not in ${...}:
        $XONSH_VENV = p"$HOME/.local/xonsh-venv"


    # XDG base user directories paths
    $XDG_CONFIG_HOME = p"$HOME/.config"
    $XDG_CACHE_HOME = p"$HOME/.cache"
    $XDG_DATA_HOME = p"$HOME/.local/share"

    # User binaries and scripts
    $PATH.add(p"$HOME/.local/bin", front = True, replace = True)
    $PATH.add(p"$HOME/.local/scripts", front = True, replace = True)

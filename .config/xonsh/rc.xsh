""" Xonsh main configuration file.

This file is loaded before the splitted configuration files found in the
rc.d directory.
"""

from pathlib import Path

def source_all(directory: Path):
    """ Sources .xsh files found in the given directory. """
    if directory.is_dir():
        for file in directory.glob("*.xsh"):
            source @(file)

# Update `os.environ` to match Xonsh environment.
$UPDATE_OS_ENVIRON = True

# Custom run control files diretories
$XONSH_ENV_CONFIG_DIR = p"$XONSH_CONFIG_DIR/env"
$XONSH_INTERACTIVE_CONFIG_DIR = p"$XONSH_CONFIG_DIR/interactive"
$XONSH_LOGIN_CONFIG_DIR = p"$XONSH_CONFIG_DIR/login"

# TODO Put it in a xontrib.
on_linux_console = "TERM" in ${...} and $TERM == "linux"

source_all($XONSH_ENV_CONFIG_DIR)

if $XONSH_LOGIN:

    # Source /etc/profile as sh
    # source-foreign /bin/sh /etc/profile # FIXME Broken ! See fix below !

    # Fixes https://github.com/xonsh/xonsh/issues/5894
    # Fixes https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile

    source_all($XONSH_LOGIN_CONFIG_DIR)

if $XONSH_INTERACTIVE:
    source_all($XONSH_INTERACTIVE_CONFIG_DIR)

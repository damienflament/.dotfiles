""" Xonsh main configuration file.

This file is loaded before the splitted configuration files found in the
rc.d directory.
"""

from pathlib import Path


def source_rc_dir(directory: Path):
    """ Sources .xsh and .py files found in the given directory. """
    # TODO Post issue about having to escape \ within glob regex
    # TODO Benchmark globbing vs Path
    # source f`{directory}/.+\\.(xsh|py)`
    if directory.is_dir():
        for f in directory.iterdir():
            if f.suffix in (".xsh", ".py"):
                source @(f)

# aliases["source-rc-dir"] = source_rc_dir

# Update `os.environ` to match Xonsh environment.
$UPDATE_OS_ENVIRON = True

# Setup custom RC directories.
$XONSH_ENV_CONFIG_DIR = p"$XONSH_CONFIG_DIR/env"
$XONSH_INTERACTIVE_CONFIG_DIR = p"$XONSH_CONFIG_DIR/interactive"
$XONSH_LOGIN_CONFIG_DIR = p"$XONSH_CONFIG_DIR/login"

# TODO Put it in a xontrib.
on_linux_console = "TERM" in ${...} and $TERM == "linux"

source_rc_dir($XONSH_ENV_CONFIG_DIR)

if $XONSH_LOGIN:
    # Source /etc/profile as sh
    # source-foreign /bin/sh /etc/profile # FIXME Broken ! See fix below !
    # Fixes https://github.com/xonsh/xonsh/issues/5894
    # Fixes https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile

    source_rc_dir($XONSH_LOGIN_CONFIG_DIR)

if $XONSH_INTERACTIVE:
    source_rc_dir($XONSH_INTERACTIVE_CONFIG_DIR)

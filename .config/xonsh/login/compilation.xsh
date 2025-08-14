""" Outils de compilation. """

$MAKEFLAGS = f"-j{__xonsh__.env['NPROC'] - 1}"
$CONFIG_SITE = p"$XDG_CONFIG_HOME/autotools/config.site"
$CFLAGS = "-Wall -Wextra -Werror"
$CTEST_OUTPUT_ON_FAILURE = 1
$SCONSFLAGS = f"--jobs={__xonsh__.env['NPROC'] - 1} --warn=all"

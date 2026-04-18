""" Outils de compilation. """

$MAKEFLAGS = "-j{}".format($NPROC - 1)
$CONFIG_SITE = p"$XDG_CONFIG_HOME/autotools/config.site"
$CFLAGS = "-Wall -Wextra -Werror"
$CTEST_OUTPUT_ON_FAILURE = 1
$SCONSFLAGS = "--jobs={} --warn=all".format($NPROC - 1)

# CHROOT par défaut pour la construction des paquets
$CHROOT = p"/tmp/archbuild/root"

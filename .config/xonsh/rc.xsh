""" Configuration de Xonsh.

Ce fichier est chargé automatiquement par Xonsh. Les RC fractionnés sont
chargés par des fonctions personnaliées.
"""

from pathlib import Path

xontrib load coreutils

$XONSH_SHOW_TRACEBACK = True


def source_rc_dir(directory: Path):
    """ Importe les scripts RC présents dans le répertoire fourni.

    Les scripts RC (Run Command) sont les fichiers de configuration de Xonsh.
    Il s'agit soit de scripts Xonsh (.xsh), soit de scripts Python (.py).
    """
    # TODO  Définir un alias correspondant:
    #        - éviter de poluer l'espace de nommage avec la fonction (xontrib ?)
    #        - vérifier les paramètres  (docopt ?)
    #        - message d'utilisation    (docopt ?)
    # FIXME Poster un ticket à propos de l'échappement obligatoire des \ dans
    #       les regexs de globbing.
    # TODO  Comparer le globbing et les fonctions de Path.
    #       source f`{directory}/.+\\.(xsh|py)`
    if directory.is_dir():
        for f in directory.iterdir():
            if f.suffix in (".xsh", ".py"):
                source @(f)

# Mise à jour de `os.environ` pour correspondre à l'environnement de Xonsh.
$UPDATE_OS_ENVIRON = True

# Définition des répertoires RC personnalisés.
$XONSH_ENV_CONFIG_DIR = p"$XONSH_CONFIG_DIR/env"
$XONSH_INTERACTIVE_CONFIG_DIR = p"$XONSH_CONFIG_DIR/interactive"
$XONSH_LOGIN_CONFIG_DIR = p"$XONSH_CONFIG_DIR/login"

# TODO Mettre dans un xontrib.
on_linux_console = "TERM" in ${...} and $TERM == "linux"

source_rc_dir($XONSH_ENV_CONFIG_DIR)

if $XONSH_LOGIN:
    # Importe le script /etc/profile en tant que Sh.
    # source-foreign /bin/sh /etc/profile # FIXME Buggé ! Voir le palliatif ci-dessous !
    # Works around https://github.com/xonsh/xonsh/issues/5894
    # Works around https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile

    source_rc_dir($XONSH_LOGIN_CONFIG_DIR)

if $XONSH_INTERACTIVE:
    source_rc_dir($XONSH_INTERACTIVE_CONFIG_DIR)

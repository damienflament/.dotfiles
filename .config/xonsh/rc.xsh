""" Configuration de Xonsh.

Ce fichier est chargé automatiquement par Xonsh. Les RC fractionnés sont
chargés par des fonctions personnaliées.
"""

$XONSH_SHOW_TRACEBACK = True

# Mise à jour de `os.environ` pour correspondre à l'environnement de Xonsh.
$UPDATE_OS_ENVIRON = True

# Permet de charger les scripts RC ainsi que les modules et xontribs.
#
# FIXME $XONSH_DATA_DIR devrait être un Path
import sys

sys.path[0:0] = [
    $XONSH_CONFIG_DIR,
    str(p"$XONSH_DATA_DIR" / "site-packages"),
]

xontrib load coreutils

# Importe les scripts RC pour configurer l'environnement du shell
import rc.env

if $XONSH_LOGIN:
    # Importe le script /etc/profile en tant que Sh.
    #
    # FIXME Buggé ! Voir le palliatif ci-dessous !
    # source-foreign /bin/sh /etc/profile
    #
    # Works around https://github.com/xonsh/xonsh/issues/5894
    # Works around https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile

    # Importe les scripts RC pour configurer les shells de connexion
    import rc.login

if $XONSH_INTERACTIVE:
    # Importe les scripts RC pour configurer les shells interactifs
    import rc.interactive

# Evite de charger les scripts RC
del sys.path[sys.path.index($XONSH_CONFIG_DIR)]

# Evite de polluer l'espace de nom global
del sys
del rc

""" Configuration de Xonsh.

Ce fichier est chargé automatiquement par Xonsh. Les RC fractionnés sont
chargés en tant que modules du paquet `rc`.
"""

from lib import ensure_xonsh_from_venv

# Mise en place de l'environnement virtuel.
$XONSH_VENV = p"~" / ".venv"
ensure_xonsh_from_venv($XONSH_VENV)

# Importation des scripts RC pour configurer l'environnement du shell
import rc.env

# Importation des scripts RC d'initialisation.
import rc.init

if $XONSH_LOGIN:
    # Importe le script /etc/profile en tant que Sh.
    #
    # FIXME Bugué ! Voir le palliatif ci-dessous !
    # source-foreign /bin/sh /etc/profile
    #
    # Contourne https://github.com/xonsh/xonsh/issues/5894
    # Contourne https://github.com/xonsh/xonsh/issues/5895
    source-bash /etc/profile


# Importe les scripts RC pour configurer les shells de connexion
# FIXME Devrait être exécuté avec $XONSH_LOGIN mais semble ne plus être effectif
# sous Gnome.
import rc.login

if $XONSH_INTERACTIVE:
    # Importe les scripts RC pour configurer les shells interactifs
    import rc.interactive

# Nettoyage de l'espace de nom global
del rc

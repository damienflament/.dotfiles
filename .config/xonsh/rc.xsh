""" Configuration de Xonsh.

Ce fichier est chargé automatiquement par Xonsh. Les RC fractionnés sont
chargés par des fonctions personnaliées.
"""

# Active l'environnement virtuel de Xonsh, si présent, et remplace le shell
# actuel par la version présente.
if $XONSH_LOGIN and $XONSH_INTERACTIVE and "XONSH_VENV" not in ${...}:
    $XONSH_VENV = p"$XONSH_DATA_DIR" / "virtualenv"

    if $XONSH_VENV.is_dir():
        source-bash @($XONSH_VENV / "bin/activate")
        exec xonsh --login --interactive


from rc.fix import home, user, xdg, path

# Active PDB si la variable d'environnement $XONSH_ENABLE_PDB est vraie.
if "XONSH_ENABLE_PDB" in ${...} and $XONSH_ENABLE_PDB:
    xontrib load pdb

# Mise à jour de `os.environ` pour correspondre à l'environnement de Xonsh.
$UPDATE_OS_ENVIRON = True

# Permet de charger les scripts RC, les modules et xontribs ainsi que les
# paquets systèmes.
#
# FIXME $XONSH_DATA_DIR devrait être un Path.
# TODO Déterminer l'emplacement des paquets systèmes.

sys.path[0:0] = [
    $XONSH_CONFIG_DIR,
    str(p"$XONSH_DATA_DIR" / "site-packages"),
    "/usr/lib/python3.13/site-packages",
]

# Rend accessible aux scripts Python systèmes les paquets système.
$PYTHONPATH = "/usr/lib/python3.13/site-packages"

# Stocke le cache Python dans un répertoire dédié.
sys.pycache_prefix = str(p"$XDG_CACHE_HOME" / "python")

# FIXME L'implémentation de `cat` semble buggée !
# xontrib load coreutils

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

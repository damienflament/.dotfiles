""" Utilitaires de gestion des environnements virtuels. """

import sys
from pathlib import Path

def ensure_xonsh_from_venv(path: Path):
    """Remplace l'instance de Xonsh actuelle par une instance provenant de
    l'environnement virtuel, si cela n'est pas déjà le cas.

    L'environnement est activé si nécessaire.
    Si aucun environnement n'est trouvé à l'emplacement `path`, un message est
    affiché.
    """

    # L'instance actuelle a déjà été lancée depuis l'environnement virtuel.
    if Path(sys.prefix) == path:
        return

    # L'environnement virtuel est introuvable.
    if not path.is_dir():
        _print_venv_installation_message()
        return

    source-bash @(path / "bin/activate")
    exec xonsh @(sys.argv[1:])

def _print_venv_installation_message():
    echo f"""
    Environnement virtuel de Xonsh non initialisé !

    Initialisez l'environnement:
    @ cd ~
    @ uv init --bare --name "xonsh-venv" --description "Xonsh virtual environment"
    @ source-bash {path}/bin/activate

    Installez Xonsh:
    @ uv add "xonsh[full]"

    Relancez une session ! 😉
"""

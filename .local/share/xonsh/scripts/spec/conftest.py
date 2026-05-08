import os
from hashlib import md5
from pathlib import Path
from shlex import quote

from _pytest.fixtures import FixtureRequest
from assertpy import add_extension
from attrs import define
from pytest import fixture
from pytestshellutils.shell import ProcessResult


def _make_command_line(args):
    if len(args) == 1:
        return str(args[0])
    else:
        return " ".join(
            map(
                lambda x: quote(str(x)),
                args,
            )
        )


@fixture
def command(shell):
    """Fournit un exécuteur de commande.

    Si la commande est spécifiée sous la forme d'une unique chaîne de
    caractères, elle est exécutée telle quelle.

    Si plusieurs arguments sont donnés, ils sont transformés en chaînes de
    caractères, échappés pour le shell puis joints par un espace. La ligne de
    commande résultante est exécutée.
    """
    return lambda *args, **kwargs: shell.run(
        _make_command_line(args),
        **kwargs,
        shell=True,
    )


# Extensions shell pour assertpy
# TODO Créer un plugin assertpy + pytest-shell-extension
def check_is_command_result(value):
    """Vérifie que la valeur est bien le résultat d'un appel à
    `shell.run()`."""
    if not isinstance(value, ProcessResult):
        raise TypeError("value is not a shell command result")


def ensure_command_result_was_checked(value):
    """Vérifie que le résultat de la commande a déjà été vérifié."""
    if not hasattr(value, "_command_result"):
        raise AssertionError(
            "the command result wasn't checked: call `succeeds()` or "
            "`fails()` first"
        )


def succeeds(self):
    """Vérifie que la valeur est le résultat d'une commande et que celle-ci
    s'est correctement terminée."""
    check_is_command_result(self.val)
    self._command_result = self.val

    if self.val.returncode != 0:
        return self.error(
            f"command failed with {self.val.returncode}"
            f" and printed to stderr: {self.val.stderr.strip()}"
        )

    return self


def fails(self):
    """Vérifie que la valeur est le résultat d'une commande et que celle-ci
    s'est terminée par une erreur."""
    check_is_command_result(self.val)
    self._command_result = self.val

    if self.val.returncode == 0:
        return self.error("command didn't fail")

    return self


def and_status(self):
    """Change le sujet des vérifications pour le code de status de la
    commande."""
    ensure_command_result_was_checked(self)

    self.val = self._command_result.returncode

    return self


def and_stdout(self):
    """Change le sujet des vérifications pour la sortie standard de la
    commande."""
    ensure_command_result_was_checked(self)

    self.val = self._command_result.stdout.strip()

    return self


def and_stderr(self):
    """Change le sujet des vérifications pour la sortie d'erreur standard de la
    commande."""
    ensure_command_result_was_checked(self)

    self.val = self._command_result.stderr.strip()

    return self


add_extension(succeeds)
add_extension(fails)
add_extension(and_status)
add_extension(and_stdout)
add_extension(and_stderr)


# TODO Créer un plugin cmd-mocker
@define
class CommandMocker:
    """Mocker de commandes shell."""

    _directory: Path
    _request: FixtureRequest

    def __attrs_post_init__(self):
        self._directory.mkdir()

    def patch(
        self,
        name: str,
        returns: int | list[int] = 0,
        outputs: str | list[str] = None,
        errors: str = None,
    ):
        """Patche une commande shell.

        Un script POSIX shell est créé pour la commande spécifiée. Ce script
        est rendu exécutable.

        La commande retourne la valeur spécifiée (:term:`0` par défaut) et
        imprime les chaînes spécifiées sur la sortie standard et la sortie
        d'erreur.
        """

        f = self._directory / name
        xdg_cache_home = Path(os.environ["XDG_RUNTIME_DIR"])
        h = md5(self._request.node.nodeid.encode()).hexdigest()
        filename = f"CommandMocker-patch-{h}-call_count"
        count_file = xdg_cache_home / filename

        content = f"""#!/bin/sh
# Fichier généré par {__file__}:CommandMocker::patch

[ ! -e {count_file} ] && echo "0" >{count_file}
read i <{count_file}
(( i = i + 1 ))
echo "$i" >{count_file}

"""

        if outputs is not None:
            if isinstance(outputs, list):
                for index, value in enumerate(outputs):
                    content += f"""
[ $i -eq {index + 1} ] && echo '{value}'
"""
            else:
                content += f"""
echo '{outputs}'
"""

        if errors is not None:
            content += f"""
echo '{errors}' >&2
"""
        if isinstance(returns, list):
            for index, value in enumerate(returns):
                content += f"""
[ $i -eq {index + 1} ] && exit {value}
"""
        else:
            content += f"""
exit {returns}
"""

        # Suppression du fichier pour réinitialiser le compteur
        if count_file.exists():
            count_file.unlink()

        f.touch()
        f.write_text(content)
        f.chmod(0o755)


@fixture
def cmd_mocker(tmp_path, shell, request):
    """Fournit un mocker de commandes shell.

    Les mocks sont des scripts POSIX shell créés dans un dossier *bin* situé
    dans le dossier temporaire fourni par la fixture *tmp_path*.

    Ce dossier *bin/* est ajouté au *PATH* de la fixture *shell* afin que les
    commandes appelées via *sell.run()* utilisent les mocks.
    """
    # L'utilisation de la fixture *tmp_path* garantit qu'un dossier
    # temporaire unique est utilisé pour chaque test et que celui-ci sera
    # également utilisé par la fonction de test si elle fait appel à la même
    # fixture.
    #
    # De la même manière, ce dossier est ajouté au *PATH* de l'environnement
    # d'exécution de la fixture *shell*. Comme la fixture *shell* n'est
    # initialisée qu'une seule fois par session, il est nécessaire de remettre
    # le *PATH* dans son état initial afin d'éviter que les mocks ne soient
    # disponibles durant le test suivant
    bin_directory = tmp_path / "bin"

    shell.environ["PATH"] = (
        str(bin_directory) + os.pathsep + shell.environ["PATH"]
    )

    yield CommandMocker(bin_directory, request)

    paths = shell.environ["PATH"].split(os.pathsep)
    paths.remove(str(bin_directory))
    shell.environ["PATH"] = os.pathsep.join(paths)

from pathlib import Path

from assertpy import assert_that
from pytest import fixture


@fixture
def makefile(lazy_shared_datadir) -> Path:
    """Un Makefile minimaliste."""
    return lazy_shared_datadir / "Makefile"


def describe_command_make_debug():
    """la commande make-debug"""

    @fixture
    def command(command_builder):
        return command_builder("make-debug")

    def it_shows_help_screen(command):
        """affiche un écran d'aide"""

        (
            assert_that(command("--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: make-debug")
        )

    def it_checks_for_Makefile(command, makefile: Path):
        """affiche une erreur si aucun Makefile n'est trouvé"""
        makefile.unlink()

        (
            assert_that(command(cwd=makefile.parent))
            .fails()
            .and_stderr()
            .is_equal_to("erreur: aucun Makefile trouvé.")
        )

    def it_shows_data_about_defined_variables(
        tmp_path,
        command,
        makefile: Path,
    ):
        """affiche des informations sur les variables définies"""
        (
            assert_that(
                command(
                    "COMMAND_LINE_VARIABLE=Variable dans la ligne de commande",
                    env={"ENVIRONMENT_VARIABLE": "Variable d'environnement"},
                    cwd=makefile.parent,
                )
            )
            .succeeds()
            .and_stdout()
            .matches(
                r"(?s).*"
                r"# Valeurs forcées \(override\) #.*"
                r"OVERRIDDEN_VARIABLE = Variable forcée.*"
                r"# Ligne de commande #.*"
                r"COMMAND_LINE_VARIABLE = Variable dans la ligne de commande.*"
                r"# Variables locales #.*"
                r"LOCAL_VARIABLE = Variable locale.*"
                r"# Valeurs par défaut #.*"
                r"# Variables d'environnement #.*"
                r"ENVIRONMENT_VARIABLE = Variable d'environnement.*"
            )
        )

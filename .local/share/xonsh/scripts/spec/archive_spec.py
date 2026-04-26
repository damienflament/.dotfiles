from pathlib import Path

from assertpy import assert_that
from pytest import fixture


@fixture
def directory(tmp_path) -> Path:
    """Un répertoire temporaire."""
    d = tmp_path / "foo"
    d.mkdir()

    return d


@fixture
def file(tmp_path) -> Path:
    """Un fichier temporaire."""
    f = tmp_path / "foo"
    f.touch()

    return f


def describe_command_archive():
    """la commande archive"""

    @fixture
    def command(command_builder):
        return command_builder("archive")

    def it_shows_help_screen(command):
        """affiche un écran d'aide"""

        (
            assert_that(command("--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: archive")
        )

    def it_asks_for_a_directory(command):
        """demande de spécifier un répertoire"""

        (
            assert_that(command())
            .fails()
            .and_stderr()
            .starts_with("Usage: archive <directory>")
        )

    def it_checks_that_the_directory_exists(command, directory: Path):
        """vérifie que le répertoire existe"""
        directory.rmdir()

        (
            assert_that(command(directory))
            .fails()
            .and_stderr()
            .is_equal_to(f"erreur: le répertoire {directory} n'existe pas.")
        )

    def it_checks_the_directory_is_a_directory(shell, file: Path):
        """vérifie que le répertoire est bien un répertoire"""
        (
            assert_that(shell.run("archive", str(file)))
            .fails()
            .and_stderr()
            .is_equal_to(f"erreur: {file} n'est pas un répertoire.")
        )

    def it_makes_the_archive_and_displays_its_name(shell, directory: Path):
        """créé une archive XZ du répertoire et affiche son nom sur la sortie
        standard"""
        r = shell.run("archive", str(directory))

        # TODO Modifier *assertpy* pour faire en sorte que la fonction
        # *is_named()* accepte les globs shell.
        (
            assert_that(r)
            .succeeds()
            .and_stdout()
            .matches(f"{directory}.+\\.tar\\.xz$")
            .is_file()
        )

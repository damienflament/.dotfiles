from pathlib import Path

from assertpy import assert_that
from pytest import fixture, mark


@fixture
def font(lazy_shared_datadir) -> Path:
    """Une police d'écriture."""
    return lazy_shared_datadir / "Aileron, Black.otf"


@fixture
def command(command_builder):
    return command_builder("font-rename")


def describe_command_font_rename():
    """la commande font-rename"""

    def it_shows_help_screen(command):
        """affiche un écran d'aide"""
        (
            assert_that(command("--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: font-rename")
        )

    def it_requires_a_filename(command):
        """nécessite un nom de fichier"""
        (
            assert_that(command())
            .fails()
            .and_stderr()
            .starts_with("Usage: font-rename <file>")
        )

    def it_checks_file_exists(command, font: Path):
        """vérifie que le fichier spécifié existe"""
        font.unlink()

        (
            assert_that(command(font))
            .fails()
            .and_stderr()
            .is_equal_to(f"erreur: le fichier {font} n'existe pas.")
        )

    def it_handles_error_from_fc_query(cmd_mocker, command, font: Path):
        """gère les erreurs provenant de la commande fc-query"""

        cmd_mocker.patch("fc-query", returns=1)

        (
            assert_that(command(font))
            .fails()
            .and_stderr()
            .starts_with(
                "erreur: impossible de lire les métadonnées de la police"
            )
        )

    def it_renames_font_file(cmd_mocker, command, font: Path):
        """renomme un fichier de police avec la famille et le style"""

        cmd_mocker.patch("fc-query", outputs="Foo,Bar")

        assert_that(command(font)).succeeds()
        assert_that(str(font)).does_not_exist()
        assert_that(str(font.with_stem("Foo, Bar"))).is_file()

    def it_does_nothing_if_the_file_is_well_named(
        cmd_mocker,
        command,
        font: Path,
    ):
        """ne fait rien si le fichier est déjà correctement nommé"""
        font = font.rename(font.with_stem("Foo, Bar"))

        cmd_mocker.patch("fc-query", outputs="Foo,Bar")

        assert_that(command(font)).succeeds()
        assert_that(str(font)).exists()

    def it_does_not_overwrite_existing_file(cmd_mocker, command, font: Path):
        """ne remplace pas un fichier existant"""

        existing_font = font.with_stem("Foo, Bar")
        existing_font.touch()

        cmd_mocker.patch("fc-query", outputs="Foo,Bar")

        (
            assert_that(command(font))
            .fails()
            .and_stderr()
            .contains(f"le fichier {existing_font} existe déjà")
        )
        assert_that(str(existing_font)).exists()
        assert_that(str(font)).exists()

    @mark.parametrize("style", ["Regular", "Normal", "Roman"])
    def it_removes_regular_style_names_from_filename(
        cmd_mocker,
        command,
        font: Path,
        style: str,
    ):
        """supprime les noms de style standards du nom de fichier"""
        cmd_mocker.patch("fc-query", outputs=f"Foo,{style}")

        assert_that(command(font)).succeeds()
        assert_that(str(font)).does_not_exist()
        assert_that(str(font.with_stem("Foo"))).exists()
        assert_that(str(font.with_stem(f"Foo, {style}"))).does_not_exist()

    @mark.parametrize(
        "style,expected",
        [
            ("08 Regular", "08"),
            ("12 Regular", "12"),
            ("55 Roman", "55"),
        ],
    )
    def it_removes_regular_names_from_style_name(
        cmd_mocker,
        command,
        style: str,
        expected: str,
        font: Path,
    ):
        """supprime les noms standards du nom de style"""

        cmd_mocker.patch("fc-query", outputs=f"Foo,{style}")

        assert_that(command(font)).succeeds()
        assert_that(str(font)).does_not_exist()
        assert_that(str(font.with_stem(f"Foo, {expected}"))).exists()
        assert_that(str(font.with_stem(f"Foo, {style}"))).does_not_exist()


@mark.integration
def integrate_command_font_rename(command, font: Path):
    """intégration de la commande font-rename"""
    initial_stem = font.stem
    font = font.rename(str(font.with_stem("foo")))

    assert_that(command(font)).succeeds()
    assert_that(str(font)).does_not_exist()
    assert_that(str(font.with_stem(initial_stem))).is_file()

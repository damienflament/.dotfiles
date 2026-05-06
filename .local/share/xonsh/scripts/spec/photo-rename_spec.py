from pathlib import Path

from assertpy import assert_that
from pytest import fixture, mark


@fixture
def photo(lazy_shared_datadir) -> Path:
    """Une photo."""
    return lazy_shared_datadir / "black.jpg"


@fixture
def another_photo(lazy_shared_datadir) -> Path:
    """Une autre photo."""
    return lazy_shared_datadir / "white.jpg"


def describe_command_photo_rename():
    """la commande photo-rename"""

    def it_show_help_screen(command):
        """affiche un écran d'aide"""
        (
            assert_that(command("photo-rename --help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: photo-rename")
        )

    def it_requires_a_filename(command):
        """nécessite un nom de fichier"""
        (
            assert_that(command("photo-rename"))
            .fails()
            .and_stderr()
            .starts_with("Usage: photo-rename <file>")
        )

    def it_allows_multiple_filenames(
        cmd_mocker,
        command,
        photo: Path,
        another_photo: Path,
    ):
        """permet de spécifier plusieurs fichiers"""

        # FIXME Le PATH est modifié lorsque le test est lancé par VSCode et
        # le script Perl *exiftool* n'est plus trouvé.
        cmd_mocker.patch("exiftool", outputs=["foo", "bar"])

        assert_that(command("photo-rename", photo, another_photo)).succeeds()

    def it_checks_file_exists(cmd_mocker, command, photo: Path):
        """vérifie que le fichier spécifié existe"""

        # FIXME Le PATH est modifié lorsque le test est lancé par VSCode et
        # le script Perl *exiftool* n'est plus trouvé.
        cmd_mocker.patch("exiftool")

        photo.unlink()

        (
            assert_that(command("photo-rename", photo))
            .fails()
            .and_stderr()
            .is_equal_to(f"erreur: le fichier {photo} n'existe pas.")
        )

    def it_handles_error_from_exiftool(cmd_mocker, command, photo: Path):
        """gère les erreurs provenant de la commande exiftool"""

        cmd_mocker.patch("exiftool", returns=1)

        (
            assert_that(command("photo-rename", photo))
            .fails()
            .and_stderr()
            .starts_with(
                "erreur: impossible de lire les métadonnées de la photo"
            )
        )

    def it_handles_empty_output_from_exiftool(
        cmd_mocker,
        command,
        photo: Path,
    ):
        """gère lorsque exiftool renvoie une chaîne vide"""

        cmd_mocker.patch("exiftool", outputs="")

        (
            assert_that(command("photo-rename", photo))
            .fails()
            .and_stderr()
            .starts_with("erreur: impossible de lire la date de la photo")
        )

    def it_renames_photo_file(cmd_mocker, command, photo: Path):
        """renomme un fichier de photo avec la date de prise de vue"""

        cmd_mocker.patch("exiftool", outputs="20200120 030712")

        assert_that(command("photo-rename", photo)).succeeds()
        assert_that(str(photo)).does_not_exist()
        assert_that(str(photo.with_stem("20200120 030712"))).is_file()

    def it_does_nothing_if_the_file_is_well_named(
        cmd_mocker,
        command,
        photo: Path,
    ):
        """ne fait rien si le fichier est déjà correctement nommé"""
        photo = photo.rename(photo.with_stem("20240120 030712"))

        cmd_mocker.patch("exiftool", outputs="20240120 030712")

        assert_that(command("photo-rename", photo)).succeeds()
        assert_that(str(photo)).exists()


@mark.skip_if_binaries_missing("exiftool")
@mark.integration
def integrate_command_photo_rename(command, photo: Path):
    """intégration de la commande font-rename"""
    initial_stem = photo.stem
    photo = photo.rename(photo.with_stem("foo"))

    assert_that(command("photo-rename", photo)).succeeds()
    assert_that(str(photo)).does_not_exist()
    assert_that(str(photo.with_stem(initial_stem))).is_file()

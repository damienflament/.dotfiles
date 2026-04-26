from assertpy import assert_that
from hypothesis import given, settings
from hypothesis import strategies as st
from pytest import fixture


def describe_command_generate_salt():
    """la commande generate-salt"""

    @fixture
    def command(command_builder):
        return command_builder("generate-salt")

    def it_shows_help_screen(command):
        """affiche un écran d'aide"""
        (
            assert_that(command("--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: generate-salt")
        )

    def it_generates_20_chars_string_by_default(command):
        """génère une chaîne de 20 caractères par défaut"""
        assert_that(command()).succeeds().and_stdout().is_length(20)

    def it_cannot_generate_negative_length_string(command):
        """ne peut générer une chaîne de longueur négative"""
        (
            assert_that(command("--length", -1))
            .fails()
            .and_stderr()
            .is_equal_to(
                "erreur: la taille spécifiée doit être de 1 au minimum."
            )
        )

    @settings(deadline=2000)
    @given(length=st.integers(min_value=1, max_value=10000))
    def it_generate_string_of_specified_length(command, length: int):
        """génère une chaîne de la longueur spécifiée"""
        (
            assert_that(command("--length", length))
            .succeeds()
            .and_stdout()
            .is_length(length)
        )

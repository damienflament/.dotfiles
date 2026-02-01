from assertpy import assert_that
from hypothesis import given, settings
from hypothesis import strategies as st


def describe_command_generate_salt():
    """la commande generate-salt"""

    def it_shows_help_screen(shell):
        """affiche un écran d'aide"""
        (
            assert_that(shell.run("generate-salt", "--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: generate-salt")
        )

    def it_generates_20_chars_string_by_default(shell):
        """génère une chaîne de 20 caractères par défaut"""
        (
            assert_that(shell.run("generate-salt"))
            .succeeds()
            .and_stdout()
            .is_length(20)
        )

    def it_cannot_generate_negative_length_string(shell):
        """ne peut générer une chaîne de longueur négative"""
        (
            assert_that(shell.run("generate-salt", "--length", str(-1)))
            .fails()
            .and_stderr()
            .is_not_empty()
        )

    @settings(deadline=2000)
    @given(length=st.integers(min_value=1, max_value=10000))
    def it_generate_string_of_specified_length(shell, length: int):
        """génère une chaîne de la longueur spécifiée"""
        (
            assert_that(shell.run("generate-salt", "--length", str(length)))
            .succeeds()
            .and_stdout()
            .is_length(length)
        )

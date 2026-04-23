from assertpy import assert_that
from hypothesis import given, settings
from hypothesis import strategies as st
from pytest import fixture


@fixture
def ip_address() -> str:
    """Une adresse IP."""

    return "192.168.1.1"


def describe_command_net_status():
    """la commande net-status"""

    def it_shows_help_screen(shell):
        """affiche un écran d'aide"""
        (
            assert_that(shell.run("net-status", "--help"))
            .succeeds()
            .and_stdout()
            .starts_with("Usage: net-status")
        )

    def it_requires_an_ip_address(shell):
        """nécessite une adresse IP"""
        (
            assert_that(shell.run("net-status"))
            .fails()
            .and_stderr()
            .starts_with("Usage: net-status")
        )

    def it_reports_unresponding_host(shell, cmd_mocker, ip_address: str):
        """indique que l'hôte ne répond pas"""

        cmd_mocker.patch(
            "ping",
            outputs="rtt min/avg/max/mdev = 1.000/1.000/1.000/0.000 ms",
            returns=1,
        )

        (
            assert_that(shell.run("net-status", ip_address))
            .fails()
            .and_stderr()
            .is_empty()
            .and_stdout()
            .is_equal_to("Pas de réponse de l'hôte.")
        )

    def it_reports_unreachable_network(shell, cmd_mocker, ip_address: str):
        """indique que le réseau est inaccessible"""

        cmd_mocker.patch("ping", returns=2)

        (
            assert_that(shell.run("net-status", ip_address))
            .fails()
            .and_stdout()
            .is_equal_to("Réseau inaccessible.")
        )

    @settings(deadline=2000)
    @given(status=st.integers(min_value=3, max_value=254))
    def it_handles_errors_from_ping(
        status, shell, cmd_mocker, ip_address: str
    ):
        """gère les codes de status inattendus provenant de la commande ping"""

        cmd_mocker.patch("ping", returns=status)

        (
            assert_that(shell.run("net-status", ip_address))
            .fails()
            .and_stderr()
            .is_equal_to("erreur: erreur inattendue de `ping`.")
        )

    def it_reports_reachable_host(shell, cmd_mocker, ip_address: str):
        """indique que l'hôte est joignable"""

        cmd_mocker.patch(
            "ping",
            outputs="rtt min/avg/max/mdev = 1.000/1.000/1.000/0.000 ms",
            returns=0,
        )

        (
            assert_that(shell.run("net-status", ip_address))
            .succeeds()
            .and_stdout()
            .contains("Connexion établie")
        )

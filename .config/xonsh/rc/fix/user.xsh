""" Garantit que $USER est défini.

# FIXME Proposer un patch (Si ce n'est pas le comportement attendu).
"""

from getpass import getuser

try:
    $USER = getuser()
except OSError:
    $USER = "<user>"

""" Garantit que $HOME existe et est un Path.

FIXME Proposer un patch.
"""

from pathlib import Path

if "HOME" not in ${...}:
    $HOME = Path.home()
elif not isinstance($HOME, Path):
    $HOME = Path($HOME)

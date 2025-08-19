""" Garantit que $PATH est un EnvPath.

FIXME Proposer un patch.
Works around https://github.com/xonsh/xonsh/issues/5870.
"""

from xonsh.tools import EnvPath

if not isinstance($PATH, EnvPath):
    $PATH = EnvPath($PATH)

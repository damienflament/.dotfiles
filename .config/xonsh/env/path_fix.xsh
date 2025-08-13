""" Fixes $PATH not being an EnvPath.

Fixes https://github.com/xonsh/xonsh/issues/5870.
"""

from xonsh.tools import EnvPath

if not isinstance($PATH, EnvPath):
    $PATH = EnvPath($PATH)

del EnvPath

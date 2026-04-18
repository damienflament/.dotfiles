""" Stocke le cache Python dans un répertoire dédié. """

import sys

sys.pycache_prefix = str(p"$XDG_CACHE_HOME" / "python")

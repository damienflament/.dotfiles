# Rend accessible les modules et xontribs utilisateurs.
#
# FIXME $XONSH_DATA_DIR devrait être un Path.

import sys

$PYTHONPATH = p"$XONSH_DATA_DIR" / "site-packages"
sys.path[0:0] = $PYTHONPATH

# Suppression des doublons
sys.path = list(dict.fromkeys(sys.path))

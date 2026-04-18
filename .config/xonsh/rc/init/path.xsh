# Rend accessible les modules et xontribs utilisateurs.
#
# FIXME $XONSH_DATA_DIR devrait être un Path.

import sys

sys.path[0:0] = [str(p"$XONSH_DATA_DIR" / "site-packages")]

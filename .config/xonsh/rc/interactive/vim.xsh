""" Vim. """

# TODO Vérifier que `vim` est disponible.
$EDITOR = "vim"

$VIMINIT = f"source {__xonsh__.env['VIM_RC']}"

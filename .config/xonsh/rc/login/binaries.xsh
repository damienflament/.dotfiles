""" Binaires et scripts utilisateurs. """

$PATH.add($HOME / ".local/bin", front = True, replace = True)
$PATH.add($HOME / ".local/scripts", front = True, replace = True)
$PATH.add(p"$XONSH_DATA_DIR" / "scripts", front = True, replace = True)

""" Active PDB si la variable d'environnement $XONSH_ENABLE_PDB est vraie."""

if "XONSH_ENABLE_PDB" in ${...} and $XONSH_ENABLE_PDB:
    xontrib load pdb

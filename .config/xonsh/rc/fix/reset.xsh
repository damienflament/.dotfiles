""" Réinitialise la configuration Xonsh.

Certaines variables sont héritées de la configuration interactive quand un
script est exécuté. Elles sont donc réinitialisées ici.

FIXME Vérifier qu'il s'agit d'un bug et poster un ticket.
"""

# Cache les traces d'exécution.
#
# Cette variable est explicitement mise à Faux afin d'éviter les messages qui
# proposent de l'utiliser.
#
$XONSH_SHOW_TRACEBACK = False

# Evite les suggestions lorsque une commande introuvable est exécutée.
$SUGGEST_COMMANDS = False

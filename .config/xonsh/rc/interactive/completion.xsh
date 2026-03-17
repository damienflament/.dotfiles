""" Complétion et suggestions du shell. """

# Génèration les complétions en arrière plan.
$COMPLETION_IN_THREAD = True

# Nécessité de presser Tabulation pour afficher le menu de complétion.
# TODO  Faire apparaître le menu avec TAB puis le mettre à jour à chaque
# pression d'une touche.
$UPDATE_COMPLETIONS_ON_KEYPRESS = False

# La touche Entrée valide la complétion mais n'exécute pas la commande.
$COMPLETION_CONFIRM = True

# Affichage de la description de la commande sous le menu.
$CMD_COMPLETIONS_SHOW_DESC = True

# Affichage d'un maximum de 100 complétions.
$COMPLETION_QUERY_LIMIT = 100

$ALIAS_COMPLETIONS_OPTIONS_LONGEST = True

# Avec `cd`, complétion des dotfiles uniquement lorsque la saisie commence par
# un point.
$COMPLETE_DOTS = "matching"

# Complétion des parenthèses, crochets et guillemets.
$XONSH_AUTOPAIR = True

# Suggestions depuis l'historique.
$XONSH_PROMPT_AUTO_SUGGEST = True

# Suggestion d'un maximum de 5 résultats lorsque une commande est introuvable.
$SUGGEST_COMMANDS = True
$SUGGEST_MAX_NUM = 5
$SUGGEST_THRESHOLD = 3

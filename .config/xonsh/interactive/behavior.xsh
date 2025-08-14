""" Comportement du shell interactif. """

if $XONSH_INTERACTIVE:

    # Changement de répertoide sans spécifier la commande `cd`.
    $AUTO_CD = True

    # Ajout des répertoires traversés à la pile.
    $AUTO_PUSHD = True

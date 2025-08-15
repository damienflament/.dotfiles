""" Aliases. """

aliases |= {
    "sudo": "sudo ",

    # Listing des fichiers
    "ls": "ls --color=auto --human-readable --group-directories-first -v",
    "l": "ls",
    "ll": "ls --format=long",
    "la": "ls --almost-all",
    "lla": "ll --almost-all",
    "lr": "ls --recursive",
    "llr": "ll --recursive",
    "lra": "lr --almost-all",
    "llra": "llr --almost-all",

    # Gestion des fichiers
    "rm": "rm --interactive=once --verbose --preserve-root",
    "mv": "mv --interactive --verbose",
    "cp": "cp --interactive --verbose --preserve=all",
    "ln": "ln --interactive --verbose",
    "rename": "rename --verbose --no-overwrite",

    "rmr": "rm --recursive",
    "cpr": "cp --recursive",

    # "mk": "\\touch",
    # "touch": "touch --no-create",
    "mkdir": "mkdir --parents --verbose",

    # Gestion des droits sur les fichiers
    "chmod": "chmod --preserve-root --verbose",
    "chown": "chown --preserve-root --verbose",
    "chgrp": "chgrp --preserve-root --verbose",

    "chmodr": "chmod --recursive",
    "chownr": "chown --recursive",
    "chgrpr": "chgrp --recursive",

    # Gestion des paquets (avec Yay)
    "yay-orphans": "yay -Q --unrequired --deps --info", # Affiche les orphelins
    "yay-clean": "yay -Y --clean",                      # Supprime les orphelins et leurs dépendances
    "yay-owner": "yay -Q --owns",                       # Cherche le paquets à qui appartient le fichier spécifié

    # Utilitaires du shell
    "pager": "$PAGER",
    "editor": "$EDITOR",

    # Commandes utilitaires
    "mount": "mount -v",
    "grep": "grep --color=auto --context=5",
    "view": "vim -R",
    "tar": "tar -v",
    "gpg": "gpg -v",
    "make": "make $MAKEFLAGS",
    "stack": f"stack --jobs {__xonsh__.env['NPROC'] - 1}",
    "mimetype": "file --brief --mime-type",
}

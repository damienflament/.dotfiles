# shellcheck shell=sh

Describe "make-debug"

  It "affiche un écran d'aide"
    When run make-debug -h
    The output should start with "Usage: make-debug"
  End

  Before "setup_directory"
  After "cleanup_directory"

  It "affiche une erreur si aucun Makefile n'est trouvé"*
    When run make-debug
    The error should not equal ""
    The status should be failure
  End

  It "affiche des informations sur les variables définies"
    echo "
      LOCAL_VARIABLE=Variable locale
      override OVERRIDDEN_VARIABLE=Variable forcée
    " >Makefile

    When run env -i PATH="$PATH" \
      ENVIRONMENT_VARIABLE="Variable d'environnement" \
      make-debug \
      COMMAND_LINE_VARIABLE="Variable dans la ligne de commande"
    The output should match pattern \
"*
# Valeurs forcées (override) #*
*
OVERRIDDEN_VARIABLE = Variable forcée*
*
# Ligne de commande #*
*
COMMAND_LINE_VARIABLE = Variable dans la ligne de commande*
*
# Variables locales #*
*
LOCAL_VARIABLE = Variable locale*
*
# Valeurs par défaut #*
*
# Variables d'environnement # *
*
ENVIRONMENT_VARIABLE = Variable d'environnement*
*"
    The status should be success
  End

End

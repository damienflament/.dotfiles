# shellcheck shell=sh

Describe "generate-salt"

  It "affiche un écran d'aide"
    When run generate-salt --help
    The output should start with "Usage: generate-salt"
  End

  It "génère une chaîne de 20 caractères par défaut"
    When run generate-salt
    The length of the output should equal 20
  End

  It "ne peut générer une chaîne de longueur négative"
    When run generate-salt --length -1
    The error should not equal ""
    The status should be failure
  End

  Parameters:value 1 2 3 4 5 10 20 50 100 200 500 1000 2000 5000 10000

  It "génère une chaîne de longueur $1"
    When run generate-salt --length "$1"
    The length of the output should equal "$1"
  End

End

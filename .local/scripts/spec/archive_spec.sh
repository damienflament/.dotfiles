# shellcheck shell=sh

Describe "archive"

  It "affiche un écran d'aide"
    When run archive --help
    The output should start with "Usage: archive"
  End

  It "demande de spécifier un répertoire"
    When run archive
    The error should start with "Usage: archive"
    The status should be failure
  End

  BeforeEach "setup_directory"
  AfterEach "cleanup_directory"

  It "vérifie que le répertoire existe"
    When run archive foo
    The error should not equal ""
    The status should be failure
  End

  It "vérifie que le répertoire est bien un répertoire"
    touch foo

    When run archive foo
    The error should not equal ""
    The status should be failure
  End

  It "créé une archive XZ du répertoire et affiche son nom sur la sortie standard"
    mkdir foo

    export output

    When call capture_output archive foo
    The file "$output" should be a file
    The output should match pattern "foo*.tar.xz"
  End
End

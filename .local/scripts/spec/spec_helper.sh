# shellcheck shell=sh

capture_output() {
  # capture_output <commande> [<argument>...]
  #
  # Exécutefe la commande spécifiée en lui passant les arguments tout en capturant
  # sa sortie.
  #
  # Cette fonction auxiliaire est conçue pour être utilisée comme un wrapper
  # autour de la fonction sujet du test. La sortie et le status sont conservés.
  export output

  [ $# -lt 1 ] && return 1

  output=$("$@")
  status=$?

  printf "%s" "$output"
  return $status
}

setup_directory() {
  # setup_directory
  #
  # Initialise un répertoire temporaire.
  #
  # Le chemin vers le répertoire créé est accessible par la variable $directory.
  # Le répertoire courant
  export directory

  directory="$(mktemp -td archive-directory.XXX)"
  cd "$directory" || return
}

cleanup_directory() {
  # cleanup_directory
  #
  # Supprime le répertoire temporaire.
  #
  # Supprime le répertoire temporaire précédement créé, dont le chemin est
  # stocké dans la variable $directory.
  rm -Rf "$directory"
}

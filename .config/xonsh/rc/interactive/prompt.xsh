""" Invite de commande. """

from my.terminal import on_linux_console
from xonsh.prompt.gitstatus import GitStatusPromptField, PromptField, PromptFields
from xonsh.prompt.gitstatus import _get_sp_output

fields = $PROMPT_FIELDS

# Restriction du chemin du répertoire courant à 30% de l'écran.
$DYNAMIC_CWD_WIDTH = "30%"
$DYNAMIC_CWD_ELISION_CHAR = "…"

# Couleur du nom d'utitilsateur (rouge pour root)
fields["user_color"] = "{{BACKGROUND_INTENSE_{}}}" \
    .format("RED" if $USER == "root" else "GREEN")

# Couleur du délimiteur de l'invite
fields["end_color"] = "{{INTENSE_{}}}" \
    .format("RED" if $USER == "root" else "GREEN")


# Numéro du terminal virtuel
fields["vtnr"] = $XDG_VTNR if "XDG_VTNR" in ${...} else None

# Niveau d'imbrication du shell
fields["shlvl"] = $SHLVL if $SHLVL > 1 else None

# Informations dur le dépôt Git courant
fields["gitstatus"].fragments = (
    ".clean",
    " ",
    ".repo",
    " ",
    ".branch",
    ".ahead",
    ".behind",
    ".staged",
    ".conflicts",
    ".changed",
    ".deleted",
    ".untracked",
    ".stash_count",
    ".operations",
    " ",
)
fields["gitstatus"].hidden = ()

@GitStatusPromptField.wrap()
def _repo(fld: PromptField, ctx: PromptFields):
    repo_path = _get_sp_output(ctx.xsh, "git", "rev-parse", "--show-toplevel").strip()
    fld.value = pf"{repo_path}".name

fields["gitstatus.repo"] = _repo

fields["gitstatus.clean"].symbol = "{BACKGROUND_INTENSE_BLACK}" if not on_linux_console else ""
fields["gitstatus.clean"].prefix = ""
fields["gitstatus.clean"].suffix = ""
fields["gitstatus.repo"].prefix = "\uf1c0 " if not on_linux_console else ""
fields["gitstatus.branch"].prefix = "\uf126 " if not on_linux_console else ""
fields["gitstatus.branch"].suffix = ""
fields["gitstatus.ahead"].prefix = " ↑"
fields["gitstatus.behind"].prefix = " ↓"
fields["gitstatus.staged"].prefix = " ✔" if not on_linux_console else " ●"
fields["gitstatus.staged"].suffix = ""
fields["gitstatus.conflicts"].prefix = " ×"
fields["gitstatus.conflicts"].suffix = ""
fields["gitstatus.changed"].prefix = " +"
fields["gitstatus.changed"].suffix = ""
fields["gitstatus.deleted"].prefix = " -"
fields["gitstatus.deleted"].suffix = ""
fields["gitstatus.untracked"].prefix = " ★" if not on_linux_console else " *"
fields["gitstatus.stash_count"].prefix = " \uf187 " if not on_linux_console else " ±"
fields["gitstatus.operations"].prefix = ""
fields["gitstatus.operations"].separator = "│"

# Invite principal
$PROMPT = (
    "\n"
    "{BLACK}"
    "{user_color} {user} "
    "{BACKGROUND_INTENSE_PURPLE} {hostname} "
    "{BACKGROUND_INTENSE_CYAN} {cwd} {RESET}"
    "\n{end_color}{prompt_end}{RESET} "
)

# Invite à droite de l'écran
$RIGHT_PROMPT = (
    "\n"
    "{BLACK}"
    "{last_return_code_if_nonzero:{BACKGROUND_INTENSE_RED} {} }"
    "{env_name: {BACKGROUND_INTENSE_CYAN} {} }"
    "{gitstatus:{BACKGROUND_INTENSE_PURPLE}{}}"
    "{shlvl:{BACKGROUND_INTENSE_BLUE} {} }"
    "{vtnr:{BACKGROUND_INTENSE_PURPLE} VT{} }"
    "{RESET}"
)

# Titre de la fenêtre
$TITLE = "{current_job:{} | }{user}@{hostname}: {cwd} | xonsh"

# Coloration de la ligne de commande.
# FIXME Problème de couleur dans la console Linux.
$COLOR_INPUT = not on_linux_console


# Indentation avec des espaces et une ligne verticale.
$INDENT = " " * 4
$MULTILINE_PROMPT = " "
$MULTILINE_PROMPT_POS = "┊"
del $MULTILINE_PROMPT_PRE

# Coloration et affichage amélioré des résultats Python.
$COLOR_RESULTS = True
$PRETTY_PRINT_RESULTS = True

# Coloration du flux standard d'erreur en rouge.
$XONSH_STDERR_PREFIX = "{BACKGROUND_RED}"
$XONSH_STDERR_POSTFIX = "{RESET}"

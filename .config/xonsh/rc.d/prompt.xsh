""" Shell prompt. """

if $XONSH_INTERACTIVE:

    fields = $PROMPT_FIELDS

    # Restrict current working directory to 30% of the screen.
    $DYNAMIC_CWD_WIDTH = "30%"
    $DYNAMIC_CWD_ELISION_CHAR = "…"

    # Username color (red for root)
    fields["user_color"] = "{{BACKGROUND_INTENSE_{}}}" \
        .format("RED" if $USER == "root" else "GREEN")

    # Virtual Terminal number when on linux console
    fields["vtnr"] = $XDG_VTNR if "XDG_VTNR" in ${...} else None

    # Shell nesting level
    fields["shlvl"] = $SHLVL if $SHLVL > 1 else None

    # Git status
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

    from xonsh.prompt.gitstatus import GitStatusPromptField, PromptField, PromptFields

    @GitStatusPromptField.wrap()
    def _repo(fld: PromptField, ctx: PromptFields):
        from xonsh.prompt.gitstatus import _get_sp_output

        repo_path = _get_sp_output(ctx.xsh, "git", "rev-parse", "--show-toplevel").strip()
        fld.value = pf"{repo_path}".parts[-1]

    del GitStatusPromptField
    del PromptField
    del PromptFields

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

    del fields

    # Main prompt
    $PROMPT = (
        "\n"
        "{BLACK}"
        "{user_color} {user} "
        "{BACKGROUND_INTENSE_PURPLE} {hostname} "
        "{BACKGROUND_INTENSE_CYAN} {cwd} "
        "{RESET} "
    )

    # Right prompt
    $RIGHT_PROMPT = (
        "\n"
        "{BLACK}"
        "{last_return_code_if_nonzero:{BACKGROUND_INTENSE_RED} {} }"
        "{gitstatus:{BACKGROUND_INTENSE_CYAN}{}}"
        "{shlvl:{BACKGROUND_INTENSE_BLUE} {} }"
        "{RESET}"
    )

    # Toolbar
    $BOTTOM_TOOLBAR = (
        "{INVERT_DEFAULT}                       "
        "{vtnr:{INVERT_PURPLE} VT{} }"
        "{INVERT_DEFAULT}                       "
        "{RESET}"
    )

    # Window title
    $TITLE = "{current_job:{} | }{user}@{hostname}: {cwd} | xonsh"

    # Colorize and indent input.
    # FIXME: Fix bug with colorized input on Linux console.
    $COLOR_INPUT = not on_linux_console

    $INDENT = " " * 4

    # Indent with spaces and a dotted vertical line multiline input.
    $MULTILINE_PROMPT = " "
    $MULTILINE_PROMPT_POS = "┊"
    del $MULTILINE_PROMPT_PRE

    # Colorize and pretty print Python results.
    $COLOR_RESULTS = True
    $PRETTY_PRINT_RESULTS = True

    # Colorize standard error stream.
    $XONSH_STDERR_PREFIX = "{BACKGROUND_RED}"
    $XONSH_STDERR_POSTFIX = "{RESET}"

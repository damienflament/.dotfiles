""" Shell completion and suggestion """

if $XONSH_INTERACTIVE:

    # Generate completions in background threads
    $COMPLETION_IN_THREAD = True

    # Need to press TAB to show completion menu.
    # TODO: Make completions show on first TAB press then update on key press
    $UPDATE_COMPLETIONS_ON_KEYPRESS = False

    # Don't run command with selected completion. Just complete.
    $COMPLETION_CONFIRM = True

    # Show description of command below completion menu.
    $CMD_COMPLETIONS_SHOW_DESC = True
    # Display a maximum of 100 completions
    $COMPLETION_QUERY_LIMIT = 100

    $ALIAS_COMPLETIONS_OPTIONS_LONGEST = True

    # With `cd`, complete dotfiles only when input starts with a dot.
    $COMPLETE_DOTS = "matching"

    # Complete parentheses, brackets, and quotes
    $XONSH_AUTOPAIR = True

    # Suggest from history.
    $AUTO_SUGGEST = True

    # Suggest max 5 commands on error.
    $SUGGEST_COMMANDS = True
    $SUGGEST_MAX_NUM = 5
    $SUGGEST_THRESHOLD = 3

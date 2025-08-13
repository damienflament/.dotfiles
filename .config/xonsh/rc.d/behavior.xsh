""" Shell behavior. """

if $XONSH_INTERACTIVE:

    # Change to specified directory without using `cd` command.
    $AUTO_CD = True

    # Push traversed directories in the stack.
    $AUTO_PUSHD = True

""" Ensures $USER is defined. """

from getpass import getuser

try:
    $USER = getuser()
except OSError:
    $USER = "<user>"

del getuser

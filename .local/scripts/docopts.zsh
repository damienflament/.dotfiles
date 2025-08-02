#! /bin/zsh

# docopt_get_help_string <filename>
#
# Fetch the help comment block from the given file.
#
function docopt_get_help_string {
	setopt re_match_pcre

	readonly filename=$1
	shift

	local line
	local withinHelp=false

	while read -r line; do
		# The help block starts at the first "# Usage:".
		if [[ $line[1,8] == "# Usage:" ]]
		then
			withinHelp=true
		fi

		if [[ $withinHelp == true ]]
		then
			# The help block ends at the first non-comment line.
			if [[ $line[1] != "#" ]]
			then
				withinHelp=false
				break
			fi

			# Gives the line removing the "#".
			echo $line[2,-1]
		fi
	done < $filename
}

# docopt_auto_parse <filename> [<argument>...]
#
# Auto parser for the same docopts usage over scripts, for laziness.
#
# Arguments:
#		<filename>		the name of the file to parse
#   <arguments>		additional arguments to pass to docopt
#
#	It uses this convention:
#  - help string in: HELP (modified in global scope)
#  - Usage is extracted by docopt_get_help_string at beginning of the script
#  - arguments are evaluated at global scope in the bash 4 assoc ARGS
#  - no version information is handled
#
function docopt_auto_parse {
	local filename=$1
	shift

	HELP="$(docopt_get_help_string $filename)"

	docopts -h $HELP : $@

	return $?
}

local caller=${${(s.:.)funcfiletrace}[1]}

eval "$(docopt_auto_parse $caller $@)"

unset caller

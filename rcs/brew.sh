# mksh: include if $(uname -s) == Darwin and $(uname -m) =~ arm


# homebrew -- add to path (on macOS with M1 chip)
# --------------------------------------------------------------------

if [[ -d /opt/homebrew/bin ]] ; then
	PATH="/opt/homebrew/bin:$PATH" # mksh: check if present
	export PATH
fi

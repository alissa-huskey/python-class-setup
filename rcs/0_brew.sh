# mksh: include if $(uname -s) == Darwin and $(uname -m) =~ arm


# homebrew -- add to path (on macOS with M1 chip)
# --------------------------------------------------------------------
# on Macs with the M1 chip the path to homebrew and its installed packages is
# not already in the path, so it needs to be added

if [[ -d /opt/homebrew/bin ]] ; then
  PATH="/opt/homebrew/bin:$PATH"  # mksh: check if present
  export PATH
fi

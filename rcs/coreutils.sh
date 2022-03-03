# mksh: include if $(uname -s) == Darwin


# gnu coreutils -- add to path
# --------------------------------------------------------------------
# https://www.gnu.org/software/coreutils/manual/html_node/index.html

if command -v brew > /dev/null \
  && read -r coreutils < <(brew --prefix coreutils 2> /dev/null) \
  && [[ -d "${coreutils}/libexec/gnubin" ]] ; then
  PATH="${coreutils}/libexec/gnubin:$PATH"  # mksh: check if present
  alias ls='ls --literal --human-readable --color=always'
fi

unset coreutils

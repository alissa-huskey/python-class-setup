# mksh: include if $(uname -s) == Darwin


# homebrew -- setup completions
# --------------------------------------------------------------------
# https://docs.brew.sh/Shell-Completion

if command -v brew >/dev/null; then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

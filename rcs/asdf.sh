

# asdf -- add asdf installed packages to path
# --------------------------------------------------------------------
# https://github.com/asdf-vm/asdf

if brew ls --versions asdf > /dev/null; then
  source "$(brew --prefix asdf)/libexec/asdf.sh"  # mksh: check if present
fi

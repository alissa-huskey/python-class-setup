

# autoenv -- auto source per-directory env files
# --------------------------------------------------------------------
# See: https://github.com/alissa-huskey/autoenv

if command -v brew > /dev/null \
   && brew --versions autoenv > /dev/null; then
  export AUTOENV_ENABLE_LEAVE=true # mksh: check if present
  export AUTOENV_ENV_LEAVE_FILENAME=".leave"
  source $(brew --prefix autoenv-revert)/activate.sh
fi


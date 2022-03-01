

# autoenv
# --------------------------------------------------------------------

if brew --versions autoenv > /dev/null; then
  export AUTOENV_ENABLE_LEAVE=true
  export AUTOENV_ENV_LEAVE_FILENAME=".leave"
  source $(brew --prefix autoenv)/activate.sh
fi


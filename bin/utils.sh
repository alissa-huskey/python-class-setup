# print an error message and exit
abort() {
  error "${@}"
  exit 1
}

error() {
  printf "\033[31mError\033[0m %s\n" "${*}"
}

pause() {
  printf -- "\n\n--- Press enter to continue. ---\n\n"
  read -r response
  if [[ "$response" == "q" ]]; then
    exit
  fi
}

# print a command
cmd() {
  printf "\033[2m# %s\033[0m\n" "${*}"
}

# print an info message in verbose mode
info() {
  is_verbose || return

  printf "\033[34m>\033[0m %s\n" "${*}"
}

# succeeds if command is available
has() {
  command -v $1 > /dev/null
}

# print a variable name and value
# usage: show_var VAR...
show_var() {
  if is_verbose; then
    return
  fi

  local var val
  while [ $# -gt 0 ]; do
    var="$1"
    eval 'val=$'"$1"

    printf "\033[33m%s\033[0m = '%s'\n" "$var" "$val"
    shift
  done
}

# succeeds if in dry run mode
is_quiet() {
  [ -n "${quiet_mode}" ]
}

# succeeds if in dry run mode
is_dry_run() {
  [ -n "${dry_run_mode}" ]
}

# succeeds if in verbose mode
is_verbose() {
  [ -n "${verbose_mode}" ]
}

# print the command then run it unless in dry run mode
run() {
  cmd "${@}"

  is_dry_run && return

  "$@"
}

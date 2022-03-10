#!/usr/bin/env bash
# shellcheck disable=SC2207
#
# flags.sh -- this program generates the shell commands to set CFLAGS and
#             LDFLAGS envionment variables with all the appropriate paths on
#             your system for installing python and writes it to ./.flags
#
# usage: flags.sh && source .flags
#

shopt -s globstar

# find all dirs in PATH that end with PATTERN
#
# usage: find_dirs PATH PATTERN
#
find_dirs() {
  local dirpath="$1" pattern="$2"
  local -a matches

  # recursively find files ending with pattern
  matches=( "${dirpath}/"**/*.${pattern} )

  # return if there are none
  [[ ${#matches[@]} -gt 0 ]] || return

  # print a unique list of directories that the files are in
  printf "%s\n" "${matches[@]}" | sed -Ee "s_/[^/]*\.${pattern}\$__" | sort -u
}

# generate shell commands to set CFLAGS, LDFLAGS, and PKG_CONFIG_PATH
# environment variables
#
# usage: make_flags
#
make_flags() {

  local -a includes libs cfgs
  local prefix cfgs

  includes+=( $(xcrun --show-sdk-path)/usr/include )

  for pkg in openssl readline bzip2 xz; do
    prefix=$(brew --prefix $pkg)

    # find all directories with .h files
    [[ -d ${prefix}/include ]] && includes+=( $(find_dirs "${prefix}/include" "h") )

    # find all directories with .a files
    [[ -d ${prefix}/lib ]] && libs+=( $(find_dirs "${prefix}/lib" "a") )

    # find all directories with .pc files
    [[ -d ${prefix}/lib/pkgconfig ]] && cfgs+=( $(find_dirs "${prefix}/lib/pkgconfig" "pc") )

  done

  printf -- 'CFLAGS="-I %s $CFLAGS"\n' "${includes[@]}"
  printf -- 'LDFLAGS="-L %s $LDFLAGS"\n' "${libs[@]}"
  printf -- 'PKG_CONFIG_PATH="%s:${PKG_CONFIG_PATH}"\n' "${cfgs[@]}"

  printf -- 'PYTHON_CONFIGURE_OPTS="--enable-shared"\n'

  printf "\nexport CFLAGS LDFLAGS PKG_CONFIG_PATH PYTHON_CONFIGURE_OPTS\n"

}

main() {
  rm -f .flags
  make_flags > .flags
}

main

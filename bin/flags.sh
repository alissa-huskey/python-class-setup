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
  local path="$1" pattern="$2"

  printf "%s\n" "${path}/"**/*.${pattern} | sed -Ee "s_/[^/]*\.${pattern}\$__" | sort -u
}

# generate shell commands to set CFLAGS and LDFLAGS environment variables
#
# usage: make_flags
#
make_flags() {

  local -a includes libs
  local prefix pkg

  includes+=( $(xcrun --show-sdk-path)/usr/include )

  for pkg in openssl readline bzip2 xz; do
    prefix=$(brew --prefix $pkg)

    if [[ -d ${prefix}/include ]]; then

      # find all directories with .h files
      includes+=( $(find_dirs "${prefix}/include" "h") )
    fi

    if [[ -d ${prefix}/lib ]]; then

      # find all directories with .a files
      libs+=( $(find_dirs "${prefix}/lib" "a") )
    fi

  done

  printf -- 'CFLAGS="-I %s $CFLAGS"\n' "${includes[@]}"
  printf -- 'LDFLAGS="-L %s $LDFLAGS"\n' "${libs[@]}"

  printf "\n\nexport CFLAGS LDFLAGS\n"

}

main() {
  rm -f .flags
  make_flags > .flags
}

main

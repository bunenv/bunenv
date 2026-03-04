# If bunx is being executed, remove bunenv's shims from PATH
# such that bunx won't find stale shims for executables that
# only exist in non-active Bun versions.
# This ensures bunx can install the necessary package on-demand.

[ "$BUNENV_COMMAND" = bunx ] || return 0

remove_from_path() {
  local path_to_remove="$1"
  local path_before
  local result=":${PATH//\~/$HOME}:"
  while [ "$path_before" != "$result" ]; do
    path_before="$result"
    result="${result//:$path_to_remove:/:}"
  done
  result="${result%:}"
  echo "${result#:}"
}

PATH="$(remove_from_path "${BUNENV_ROOT}/shims")"
export PATH

if [[ ! -o interactive ]]; then
    return
fi

compctl -K _bunenv bunenv

_bunenv() {
  local words completions
  read -cA words

  if [ "${#words}" -eq 2 ]; then
    completions="$(bunenv commands)"
  else
    completions="$(bunenv completions ${words[2,-2]})"
  fi

  reply=(${(ps:\n:)completions})
}

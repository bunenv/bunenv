setup() {
  BUNENV_TEST_DIR="$(mktemp -d "${BATS_TMPDIR}/bunenv.XXXXXX")"
  export BUNENV_TEST_DIR

  export BUNENV_ROOT="${BUNENV_TEST_DIR}/root"
  export HOME="${BUNENV_TEST_DIR}/home"
  export BUNENV_HOOK_PATH="${BUNENV_ROOT}/bunenv.d:${BATS_TEST_DIRNAME}/../bunenv.d"

  mkdir -p "$BUNENV_ROOT" "$HOME" "$BUNENV_ROOT/shims" "$BUNENV_ROOT/versions" "$BUNENV_TEST_DIR/bin"

  PATH=/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin
  PATH="${BUNENV_TEST_DIR}/bin:${BATS_TEST_DIRNAME}/../bin:${BATS_TEST_DIRNAME}/../libexec:$PATH"
  export PATH

  unset BUNENV_VERSION BUNENV_DIR BUNENV_DEBUG
}

teardown() {
  rm -rf "$BUNENV_TEST_DIR"
}

create_executable() {
  local version="$1"
  local exe="$2"
  local full_path="${BUNENV_ROOT}/versions/${version}/bin/${exe}"

  mkdir -p "${full_path%/*}"
  cat > "$full_path" <<'SH'
#!/usr/bin/env bash
echo "ok"
SH
  chmod +x "$full_path"
}

create_bun_version() {
  local version="$1"
  create_executable "$version" bun
  ln -sf bun "${BUNENV_ROOT}/versions/${version}/bin/bunx"
}

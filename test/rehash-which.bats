#!/usr/bin/env bats

load test_helper

@test "rehash creates bun and bunx shims" {
  create_bun_version "1.0.0"

  run bunenv rehash
  [ "$status" -eq 0 ]

  [ -x "${BUNENV_ROOT}/shims/bun" ]
  [ -x "${BUNENV_ROOT}/shims/bunx" ]
}

@test "which resolves executable in selected version" {
  create_bun_version "1.0.0"

  run bunenv global 1.0.0
  [ "$status" -eq 0 ]

  run bunenv which bun
  [ "$status" -eq 0 ]
  [ "$output" = "${BUNENV_ROOT}/versions/1.0.0/bin/bun" ]
}

@test "which resolves system bun when BUNENV_VERSION=system" {
  cat > "${BUNENV_TEST_DIR}/bin/bun" <<'SH'
#!/usr/bin/env bash
echo "system-bun"
SH
  chmod +x "${BUNENV_TEST_DIR}/bin/bun"

  run env BUNENV_VERSION=system bunenv which bun
  [ "$status" -eq 0 ]
  [ "$output" = "${BUNENV_TEST_DIR}/bin/bun" ]
}

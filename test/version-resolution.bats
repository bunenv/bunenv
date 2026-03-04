#!/usr/bin/env bats

load test_helper

@test "global version is used when set" {
  create_bun_version "1.0.0"

  run bunenv global 1.0.0
  [ "$status" -eq 0 ]

  run bunenv version-name
  [ "$status" -eq 0 ]
  [ "$output" = "1.0.0" ]
}

@test "local .bun-version overrides global" {
  create_bun_version "1.0.0"
  create_bun_version "1.1.0"

  run bunenv global 1.0.0
  [ "$status" -eq 0 ]

  mkdir -p "$BUNENV_TEST_DIR/project"
  cd "$BUNENV_TEST_DIR/project"
  echo "1.1.0" > .bun-version

  run bunenv version-name
  [ "$status" -eq 0 ]
  [ "$output" = "1.1.0" ]
}

@test "BUNENV_VERSION env var overrides local and global" {
  create_bun_version "1.0.0"
  create_bun_version "1.1.0"

  run bunenv global 1.0.0
  [ "$status" -eq 0 ]

  mkdir -p "$BUNENV_TEST_DIR/project"
  cd "$BUNENV_TEST_DIR/project"
  echo "1.1.0" > .bun-version

  BUNENV_VERSION=1.0.0 run bunenv version-name
  [ "$status" -eq 0 ]
  [ "$output" = "1.0.0" ]
}

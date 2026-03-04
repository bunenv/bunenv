#!/usr/bin/env bats

load test_helper

@test "install --list returns versions" {
  if [ "${RUN_NETWORK_TESTS:-0}" != "1" ]; then
    skip "network tests disabled"
  fi

  run bunenv install --list
  [ "$status" -eq 0 ]
  [[ "$output" == *"1."* ]]
}

@test "install, activate, and uninstall real Bun version" {
  if [ "${RUN_NETWORK_TESTS:-0}" != "1" ]; then
    skip "network tests disabled"
  fi

  run bunenv install 1.3.10
  [ "$status" -eq 0 ]

  run bunenv global 1.3.10
  [ "$status" -eq 0 ]

  run "${BUNENV_ROOT}/shims/bun" --version
  [ "$status" -eq 0 ]
  [[ "$output" == "1.3.10"* ]]

  run bunenv uninstall -f 1.3.10
  [ "$status" -eq 0 ]
  [[ "$output" == *"Uninstalled Bun 1.3.10"* ]]
}

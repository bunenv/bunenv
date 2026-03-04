#!/usr/bin/env bats

load test_helper

@test "blank invocation fails and prints help" {
  run bunenv
  [ "$status" -ne 0 ]
  [[ "$output" == *"Usage: bunenv <command>"* ]]
}

@test "default BUNENV_ROOT is HOME/.bunenv" {
  run env -u BUNENV_ROOT HOME="$BUNENV_TEST_DIR/custom-home" bunenv root
  [ "$status" -eq 0 ]
  [ "$output" = "$BUNENV_TEST_DIR/custom-home/.bunenv" ]
}

@test "commands includes core bunenv commands" {
  run bunenv commands
  [ "$status" -eq 0 ]
  [[ "$output" == *"install"* ]]
  [[ "$output" == *"uninstall"* ]]
  [[ "$output" == *"version"* ]]
  [[ "$output" == *"which"* ]]
  [[ "$output" == *"rehash"* ]]
}

@test "bunenv --version reports initial version" {
  run bunenv --version
  [ "$status" -eq 0 ]
  [[ "$output" == "bunenv 0.0.1"* ]]
}

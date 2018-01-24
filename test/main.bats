# This is a bats test file
# See also:
# https://github.com/sstephenson/bats

@test "no arguments" {
    run atom
    [ "$status" -eq 0 ]
    [ "${lines[0]}" = "atom: no commands specified" ]
}

@test "help" {
    skip
}

@test "debug" {
    skip
}

@test "push with no args" {
    skip
}

@test "push to IP" {
    skip
}

@test "push to serial" {
    skip
}

@test "create-template with no args" {
    skip
}

@test "create-template" {
    skip
}

@test "create-template second time doesn't install" {
    skip
}

@test "install" {
    skip
}

@test "search" {
    skip
}
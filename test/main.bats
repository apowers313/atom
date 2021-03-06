# This is a bats test file
# See also:
# https://github.com/sstephenson/bats

# setup mocks
export PATH="`pwd`/test/helper":$PATH

setup() {
    rm -f *.mocklog .mockcount.tmp
}

teardown() {
    rm -f *.mocklog .mockcount.tmp
}

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
    mock.adb.1() {
        echo "device"
    }
    export -f mock.adb.1
    atom push 10.100.100.150
    [ -s adb.mocklog ]

    diff adb.mocklog <(cat << EOF
connect 10.100.100.150
-s 10.100.100.150 get-state
-s 10.100.100.150 root
connect 10.100.100.150
-s 10.100.100.150 remount
-s 10.100.100.150 push $HOME/.atom/staging/android21-arm-generic/* /data/local/tmp
EOF)
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
    run atom install foobar
    [ -s pkg.mocklog ]

    diff pkg.mocklog <(cat << EOF
-C $HOME/.atom/pkg.conf -r $HOME/.atom/vendor/android-21/arm/ install foobar
EOF)
}

@test "search" {
    run atom search blahpkg
    [ -s pkg.mocklog ]

    diff pkg.mocklog <(cat << EOF
-C $HOME/.atom/pkg.conf search blahpkg
EOF)
}
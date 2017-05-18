#!/bin/bash

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
IMAGE="${IMAGE:-jrbeverly/baseimage:alpine}"

# Tests
#
# The functions that test certain functionality.

function user()
{
    docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.user" }}' $IMAGE
}

function group()
{
    docker inspect -f '{{ index .Config.Labels "io.gitlab.jrbeverly.user" }}' $IMAGE
}

function empty_cache()
{
    docker run --rm $IMAGE sh -c "ls -1 /var/cache/apk | wc -l"
}

function install()
{
    docker run --rm $IMAGE apk add --update zip
}

(
    [[ "${BASH_SOURCE[0]}" == "${0}" ]] || exit 0
    function assertEquals()
    {
        msg=$1; shift
        expected=$1; shift
        actual=$1; shift
        /bin/echo -n "$msg: "
        if [ "$expected" != "$actual" ]; then
            echo "FAILED: EXPECTED=$expected ACTUAL=$actual"
        else
            echo PASSED
        fi
    }


    echo "Testing image $IMAGE"
    (
      RESULT=$(user)
      assertEquals "user label is present" 9000 $RESULT
    )

    (
      RESULT=$(group)
      assertEquals "group label is present" 9000 $RESULT
    )

    (
      RESULT=$(empty_cache)
      assertEquals "the cache is empty" 0 $?
    )

    (
      RESULT=$(install)
      assertEquals "install to image" 0 $?
    )
)
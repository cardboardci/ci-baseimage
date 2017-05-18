#!/bin/sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
IMAGE_ARG="$1"
export IMAGE="${IMAGE_ARG:-jrbeverly/baseimage:alpine}"

# Tests
#
# Run tests
sh ${ROOT_DIR}/tests/tests_alpine.sh

(
    function assertEquals()
    {
        msg=$1
        expected=$2
        actual=$3

        if [ "$expected" != "$actual" ]; then
            echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
        else
            echo "$msg: PASSED"
        fi
    }

    # Tests specific to this image.
)
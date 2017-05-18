#!/bin/bash

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
IMAGE_ARG="$1"
export IMAGE="${IMAGE_ARG:-jrbeverly/baseimage:ubuntu}"

# Tests
#
# Run tests
sh ${ROOT_DIR}/tests/tests_ubuntu.sh

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

    # Tests specific to this image.
)
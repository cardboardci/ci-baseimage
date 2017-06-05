#!/bin/sh

# 
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"

# 
# Tests
#

function is_empty_apk()
{
    ls -1 /var/cache/apk | wc -l >/dev/null 2>&1  
}

function is_empty_apt()
{
    ls -1 /var/lib/apt/lists/ | wc -l >/dev/null 2>&1  
}

function install_apk()
{
    apk add --update zip
}

function install_apt()
{
    apt-get update
}

# 
# Framework
#

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

function assertNotEquals()
{
    msg=$1
    expected=$2
    actual=$3

    if [ "$expected" == "$actual" ]; then
        echo "$msg: FAILED: EXPECTED=$expected ACTUAL=$actual"
    else
        echo "$msg: PASSED"
    fi
}
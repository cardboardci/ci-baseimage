#!/bin/sh

# Variables
#
# Variables of the script.
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
export IMAGE=jrbeverly/baseimage:alpine

# Tests
#
# Run tests
sh ${ROOT_DIR}/tests/tests_alpine.sh
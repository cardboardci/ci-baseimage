#!/bin/sh

# 
# Variables
#
SCRIPT=$(readlink -f "$0")
DIR="$(dirname $SCRIPT)"
ROOT_DIR="$(dirname $DIR)"
BIN_DIR="${DIR}/target"
DATA_DIR="${DIR}/resources"
LIB_DIR="${DIR}/lib"

# 
# Tests
#
source $LIB_DIR/testbase.sh

function is_go_installed() {
  go version
}

#
# Test Runner
#
(
    rm -rf $BIN_DIR
    mkdir -p $BIN_DIR

    (
      RESULT=$(is_empty_apt)
      assertEquals "the cache is empty" 0 $?
    )

    (
      RESULT=$(install_apt)
      assertEquals "install to image" 0 $?
    )

    (
      RESULT=$(is_go_installed)
      assertEquals "go installed" 0 $?
    )
)
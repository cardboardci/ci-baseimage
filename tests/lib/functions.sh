#!/bin/sh

# Tests
#
# A set of common functions that should be tested on the docker image.

is_empty_apk()
{
    ls -1 /var/cache/apk | wc -l >/dev/null 2>&1  
}

is_empty_apt()
{
    mkdir -p /var/lib/apt/lists/
    ls -1 /var/lib/apt/lists/ | wc -l >/dev/null 2>&1  
}

install_apk()
{
    apk add --update zip >/dev/null 2>&1
}

install_apt()
{
    apt-get update >/dev/null 2>&1  
    apt-get install -y zip >/dev/null 2>&1  
}
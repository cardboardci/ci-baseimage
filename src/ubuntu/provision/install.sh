#!/bin/sh
set -x
cd /tmp/

apt-get -y update 
apt-get -y upgrade

apt-get install -y ca-certificates bash

apt-get clean
rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
#!/bin/sh
set -ex
cd /tmp/

apt-get update -y
apt-get -y upgrade

apt-get install -y ca-certificates curl bash

apt-get clean
rm -rf /tmp/* /var/tmp/* /var/lib/apt/lists/*
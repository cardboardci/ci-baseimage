#!/bin/sh
set -ex
cd /tmp/

apk update
apk upgrade

apk add --update --no-cache ca-certificates curl bash

rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
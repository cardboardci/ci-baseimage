#!/bin/sh
set -ex
cd /tmp/

apk add --update --no-cache ca-certificates bash
apk upgrade

rm -rf /tmp/* /var/tmp/* /var/cache/apk/*
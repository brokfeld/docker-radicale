#!/bin/sh

# add user
adduser radicale --system --uid $USER_UID
addgroup radicale --system --gid $USER_GID

# set permissions
chown -R radicale:radicale /app/data
chmod 700 -R radicale:radicale /app/data

# exec all as radicale user
runuser -u radicale -- "$@"

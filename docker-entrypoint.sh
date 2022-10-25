#!/bin/sh

# set permissions
chown -R radicale /app/data

# exec all as radicale user
runuser -u radicale -- "$@"

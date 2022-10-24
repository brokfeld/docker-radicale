#!/bin/sh

# set permissions
chown -R radicale:radicale /app/data

# exec all as radicale user
su - radicale -c "$@"

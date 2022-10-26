#!/bin/sh

# set USER_UID, if not set
if [[ -z ${USER_UID} ]];
then
  USER_UID=2050
fi

# set USER_GID, if not set
if [[ -z ${USER_GID} ]];
then
  USER_GID=2050
fi

# add user for exec
adduser radicale --system --uid $USER_UID
addgroup radicale --system --gid $USER_GID

# set dir permissions
chown -R radicale:radicale /app/data
chmod 700 -R /app/data

# exec all as radicale user
runuser -u radicale -- "$@"

#!/bin/bash

# Variables from environement
: "${SALT_USE:=master}"
: "${SALT_NAME:=master}"
: "${LOG_LEVEL:=info}"
: "${OPTIONS:=}"

if [ "${SALT_USE}" = "master" ]; then

    echo "INFO: Starting salt-$SALT_USE with log level $LOG_LEVEL with hostname $SALT_NAME"
    echo "log_level: ${LOG_LEVEL}" > /etc/salt/master.d/logging.conf
    echo "log_level_logfile: quiet" >> /etc/salt/master.d/logging.conf


    # Should we start the API ?
    if [ ! -z "$SALT_API" ]; then
        /usr/bin/salt-api &
    fi

    /usr/bin/salt-master


elif [ "${SALT_USE}" = "minion" ]; then
    # Set minion id
    echo $SALT_NAME > /etc/salt/minion_id

    # Set salt grains
    if [ ! -z "$SALT_GRAINS" ]; then
      echo "INFO: Set grains on $SALT_NAME to: $SALT_GRAINS"
      echo $SALT_GRAINS > /etc/salt/grains
    fi

    echo "INFO: Starting salt-$SALT_USE with log level $LOG_LEVEL with hostname $SALT_NAME"
    echo "log_level: ${LOG_LEVEL}" > /etc/salt/minion.d/logging.conf
    /usr/bin/salt-minion
fi


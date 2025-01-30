#!/bin/bash

SOCK_FILE=$1
GROUP_NAME=$2

TIMEOUT=30
INTERVAL=1

START=$(date +%s)

echo "Waiting for $SOCK_FILE to be created..."

while [ ! -e "$SOCK_FILE" ]; do
    # Calculate elapsed time
    NOW=$(date +%s)
    ELAPSED=$((NOW - START))

    # Check if timeout has reached
    if [ "$ELAPSED" -ge "$TIMEOUT" ]; then
        echo "Timeout reached: $SOCK_FILE was not created within $TIMEOUT seconds."
        exit 1
    fi

    sleep "$INTERVAL"
done

echo "$SOCK_FILE has been created."
chown root:$GROUP_NAME $SOCK_FILE
chmod g+w $SOCK_FILE
echo "Write permissions for the $SOCK_FILE have been granted to the group $GROUP_NAME"

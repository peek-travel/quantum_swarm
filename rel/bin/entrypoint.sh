#!/bin/ash -e

export NODE_IP=$(hostname -i)

exec "$@"

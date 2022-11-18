#!/bin/sh
set -e

if [ ! -f UUID ] && [ -z "$UUID" ]; then
	cat /proc/sys/kernel/random/uuid > UUID
elif [ ! -f UUID ] && [ -n "$UUID" ]; then
	echo $UUID > UUID
fi

# Set config.json
if [ ! -f /etc/xray/config.json ]; then
	UUID=$(cat UUID)
	cp /etc/xray/config.init /etc/xray/config.json
	sed -i "s/PORT/$PORT/g" /etc/xray/config.json
	sed -i "s/UUID/$UUID/g" /etc/xray/config.json
	sed -i "s/DEST/$DEST/g" /etc/xray/config.json
	echo "Xray Initialized"
	echo "UUID:$UUID"
	echo "Listening at 0.0.0.0:$PORT"
	echo "Fallback to $DEST"
fi

exec "$@"

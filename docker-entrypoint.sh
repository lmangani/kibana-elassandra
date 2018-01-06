#!/bin/bash
set -e

if [ -n "$ADMIN_USER" ] && [ -n "$ADMIN_PASS" ]; then
   echo "{}" > /usr/share/kibana/plugins/kbn-authentication-plugin/users.json
   /usr/share/kibana/node/bin/node /usr/share/kibana/plugins/kbn-authentication-plugin/adduser.js $ADMIN_USER $ADMIN_PASS
else
   echo "{}" > /usr/share/kibana/plugins/kbn-authentication-plugin/users.json
   /usr/share/kibana/node/bin/node /usr/share/kibana/plugins/kbn-authentication-plugin/adduser.js admin elassandra
fi

# Add kibana as command if needed
if [[ "$1" == -* ]]; then
	set -- kibana "$@"
fi

# Run as user "kibana" if the command is "kibana"
if [ "$1" = 'kibana' ]; then
	if [ "$ELASTICSEARCH_URL" ]; then
		sed -ri "s!^(\#\s*)?(elasticsearch\.url:).*!\2 '$ELASTICSEARCH_URL'!" /etc/kibana/kibana.yml
	fi

	set -- gosu kibana tini -- "$@"
fi

exec "$@"

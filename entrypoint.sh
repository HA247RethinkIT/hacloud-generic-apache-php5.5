#!/bin/bash

# Update Apache port
sed -i "s/PORT/$PORT/g" /etc/apache2/ports.conf
sed -i "s/PORT/$PORT/g" /etc/apache2/sites-enabled/000-default

# Set any variables we have in the env for php.
# Only match names starting PHP_ followed by a lowercase ini directive.
# Ubuntu 12.04/13.04 scan /etc/php5/conf.d, 14.04+ scan a conf.d per SAPI,
# so write to every one that exists.
for CONF_DIR in /etc/php5/conf.d /etc/php5/apache2/conf.d /etc/php5/cli/conf.d; do
    [ -d "$CONF_DIR" ] && [ ! -L "$CONF_DIR" ] || continue
    printenv | grep '^PHP_[a-z]' | sed 's/^PHP_//' > "$CONF_DIR/user.ini"
    # Hide PHP Version
    echo 'expose_php = Off' >> "$CONF_DIR/user.ini"
done

# Start apache
/usr/sbin/apache2ctl -DFOREGROUND


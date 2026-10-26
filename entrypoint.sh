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
    # PHP2Shell (CVE-2026-109618 / CVE-2026-109619) mitigation. Written first
    # so a PHP_session.upload_progress.enabled env var can still override it.
    echo 'session.upload_progress.enabled = 0' > "$CONF_DIR/user.ini"
    printenv | grep '^PHP_[a-z]' | sed 's/^PHP_//' >> "$CONF_DIR/user.ini"
    # Hide PHP Version
    echo 'expose_php = Off' >> "$CONF_DIR/user.ini"
done

# Start apache
/usr/sbin/apache2ctl -DFOREGROUND


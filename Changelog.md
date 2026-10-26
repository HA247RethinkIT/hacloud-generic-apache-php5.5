# Change Log
All notable changes to this project will be documented in this file.

##
## [Unreleased]
### Fix
- Write PHP_* settings to /etc/php5/apache2/conf.d and /etc/php5/cli/conf.d. /etc/php5/conf.d does not exist on Ubuntu 14.04, so no settings were being applied
- Only read environment variables that start with PHP_ followed by a lowercase ini directive

##
## [0.0.1]
### Add
- First release of the project. Intended for use with HA Cloud forked from https://github.com/HA247RethinkIT/hacloud-generic-apache-php5.3

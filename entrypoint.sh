#!/bin/bash

chmod 777 -R /var/www/php

/etc/init.d/php8.1-fpm start -R

nginx -g "daemon off;"

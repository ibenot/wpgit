#!/bin/sh
clear
echo "
///////////////////////////////,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,     
(////////////////@@/////////@@(,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,    
 ////////////////@@////////(@@/,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,   
 ////////////////@@/#@@@&//(@@//@@*(@@@&*,,,/&@@@@(,/@@,,,,,(@@,,,,,,,,,,,,,   
 ////////////////@@@(/(@@@/(@@/(@@@(,,*@@@,,//,,,%@@*%@&,,,/@@,,,,,,,,,,,,,,,  
  ///////////////@@////(@@/(@@/(@@*,,,,,@@%,,%@@&%@@%,@@&,,@@/,,,,,,,,,,,,,,,  
  (//////////////@@////(@@/(@@/(@@(,,,,,@@#@@%,,,,@@%,,@@(&@%,,,,,,,,,,,,,,,,, 
   //////////////@@////(@@/(@@/(@@@@(*%@@@,@@@,,,&@@%,,*@@@&,,,,,,,,,,,,,,,,,, 
    /////////////@@////(@@/(@@/(@@*,(@@*,,,,,(@@/,((/,,,*@@,,,,,,,,,,,,,,,,,,,,
    ///////////////////////////(@@*,,,,,,,,,,,,,,,,,,&@@@@,,,,,,,,,,,,,,,,,,,,,
     //////////////////////////////,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,,
"

# --------------------------- REQUIRED COMPONENTS ------------------------------

# If WP-cli is not available
if ! [ -x "$(command -v wp)" ]; then
  echo 'WP-CLI is not already installed...\nInstallation:' >&2
  curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
  chmod +x wp-cli.phar
  sudo mv wp-cli.phar /usr/local/bin/wp
  echo "WP-CLI is now installed!"
fi

# If Composer is not available
if ! [ -x "$(command -v composer)" ]; then
  echo 'COMPOSER is not installed...\nInstallation:' >&2
  curl -sS https://getcomposer.org/installer | php
  mv composer.phar /usr/local/bin/composer
  echo "COMPOSER is now installed!"
fi

# We're ready to start installation...
echo "REQUIRED COMPONENTS..."
wp --version
composer --version
echo ""

# --------------------------- Init install ------------------------------

# Duplicate dist config file
cp dev-config.sample.php dev-config.php

#Current date and time
NOW=$(date +"%d-%m-%Y-%H-%M-%S")

# Read config
DB_NAME=wpgit_test_$NOW
DB_USER=root
DB_PASSWORD=root
DB_HOST=localhost
VHOST_IP="developer.hipay.dev"
VHOST_PORT="8888"

# --------------------------- Read user config ------------------------------

echo "------------------- DB Settings -------------------"
# Read user settings
read -p "DB_NAME [$DB_NAME]: " CUSTOM_DB_NAME
CUSTOM_DB_NAME=${CUSTOM_DB_NAME:-$DB_NAME}
read -p "DB_USER [$DB_USER]: " CUSTOM_DB_USER
CUSTOM_DB_USER=${CUSTOM_DB_USER:-$DB_USER}
read -p "DB_PASSWORD [$DB_PASSWORD]: " CUSTOM_DB_PASSWORD
CUSTOM_DB_PASSWORD=${CUSTOM_DB_PASSWORD:-$DB_PASSWORD}
read -p "DB_HOST [$DB_HOST]: " CUSTOM_DB_HOST
CUSTOM_DB_HOST=${CUSTOM_DB_HOST:-$DB_HOST}

echo "\n------------------- Vhost Settings -------------------"
read -p "VHOST_IP [$VHOST_IP]: " CUSTOM_VHOST_IP
CUSTOM_VHOST_IP=${CUSTOM_VHOST_IP:-$VHOST_IP}
read -p "VHOST_PORT [$VHOST_PORT]: " CUSTOM_VHOST_PORT
CUSTOM_VHOST_PORT=${CUSTOM_VHOST_PORT:-$VHOST_PORT}

# Define DB config
echo "\n\ndefine('DB_NAME', '$CUSTOM_DB_NAME');" >> dev-config.php
echo "define('DB_USER', '$CUSTOM_DB_USER');" >> dev-config.php
echo "define('DB_PASSWORD', '$CUSTOM_DB_PASSWORD');" >> dev-config.php
echo "define('DB_HOST', '$CUSTOM_DB_HOST');" >> dev-config.php

# --------------------------- Search & replace ------------------------------

# URL Search in dump.sql
URL_SEARCH=`grep home dump.sql | cut -d \' -f 10`
echo "URL Search: "$URL_SEARCH

# URL Replace
URL_REPLACE="http://"$CUSTOM_VHOST_IP":"$CUSTOM_VHOST_PORT
echo "URL Replace: "$URL_REPLACE

#Update wp-config WP_CONTENT_URL
echo "define( 'WP_CONTENT_URL', '$URL_REPLACE/public/wp-content' );" >> dev-config.php

# --------------- Composer -----------------------------

# Composer
composer install

# --------------- WP-Cli -----------------------------
# Create database
wp db create

# Import dump.sql 
wp db import dump.sql

# Search & Replace URL in db
wp search-replace $URL_SEARCH $URL_REPLACE

# Fix home URL
wp option update home $URL_REPLACE

# Fix siteurl
wp option update siteurl $URL_REPLACE"/public/wp"

# Regenerate .htaccess to enable URL Rewriting
wp rewrite structure '/%postname%/' --hard

# Check installed Plugins & thèmes
wp plugin status
wp theme status

# --------------- Finish -----------------------------

echo "\n***************************************************************"
echo $URL_REPLACE
echo "****************************************************************\n"

#!/bin/sh

# Clearing prompt
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

# Duplicate dist config file
cp dev-config.sample.php dev-config.php

#Current date and time
NOW=$(date +"%d-%m-%Y-%H-%M-%S")

# Read config
DB_NAME=wpgit_test_$NOW
DB_USER=root
DB_PASSWORD=root
DB_HOST=localhost
IP="localhost:8888"

# Read user settings
read -p "DB_NAME [$DB_NAME]: " CUSTOM_DB_NAME
CUSTOM_DB_NAME=${CUSTOM_DB_NAME:-$DB_NAME}
read -p "DB_USER [$DB_USER]: " CUSTOM_DB_USER
CUSTOM_DB_USER=${CUSTOM_DB_USER:-$DB_USER}
read -p "DB_PASSWORD [$DB_PASSWORD]: " CUSTOM_DB_PASSWORD
CUSTOM_DB_PASSWORD=${CUSTOM_DB_PASSWORD:-$DB_PASSWORD}
read -p "DB_HOST [$DB_HOST]: " CUSTOM_DB_HOST
CUSTOM_DB_HOST=${CUSTOM_DB_HOST:-$DB_HOST}
read -p "IP [$IP]: " CUSTOM_IP
CUSTOM_IP=${CUSTOM_IP:-$IP}

# Define DB config
echo "\n\ndefine('DB_NAME', '$CUSTOM_DB_NAME');" >> dev-config.php
echo "define('DB_USER', '$CUSTOM_DB_USER');" >> dev-config.php
echo "define('DB_PASSWORD', '$CUSTOM_DB_PASSWORD');" >> dev-config.php
echo "define('DB_HOST', '$CUSTOM_DB_HOST');" >> dev-config.php

# Show DB config
WPDBNAME=`cat dev-config.php | grep DB_NAME | cut -d \' -f 4`
WPDBUSER=`cat dev-config.php | grep DB_USER | cut -d \' -f 4`
WPDBPASS=`cat dev-config.php | grep DB_PASSWORD | cut -d \' -f 4`
WPDBHOST=`cat dev-config.php | grep DB_HOST | cut -d \' -f 4`
echo "\nDB_NAME: "$WPDBNAME
echo "DB_USER: "$WPDBUSER
echo "DB_PASSWORD: "$WPDBPASS
echo "DB_HOST: "$WPDBHOST
echo

# URL Search in dump.sql
URL_SEARCH=`grep home dump.sql | cut -d \' -f 10`
echo "URL Search: "$URL_SEARCH

#Full path
CURRENT_PATH=$PWD

#Current folder (partial path)
CURRENT_DIRECTORY=${PWD##*/}

# URL Replace
URL_REPLACE="http://"$CUSTOM_IP"/"$CURRENT_DIRECTORY
echo "URL Replace: "$URL_REPLACE

#Update wp-config WP_CONTENT_URL
echo "define( 'WP_CONTENT_URL', '$URL_REPLACE/public/wp-content' );" >> dev-config.php

# WP-Cli
wp --info
composer install
wp db create
wp db import dump.sql
wp search-replace $URL_SEARCH $URL_REPLACE
wp option update home $URL_REPLACE
wp option update siteurl $URL_REPLACE"/public/wp"
wp rewrite structure '/%postname%/'
wp plugin status
wp theme status

echo "******************************************"
echo "Dev Portal is ready on: "$URL_REPLACE
echo "******************************************"

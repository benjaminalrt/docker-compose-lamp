#!/bin/bash
RED='\033[0;31m'
GREEN='\033[0;32m'
NC='\033[0m'

APACHE='/etc/apache2/sites-available/'
APACHE_ENABLED='/etc/apache2/sites-enabled/'
TEMPLATE_SSL='/etc/apache2/sites-available/template-ssl.conf'
TEMPLATE='/etc/apache2/sites-available/template.conf'

# Dossier
FOLDER=""
if [ -z "$1" ]
  then
    echo "Quel est le document root de ton projet ? (exemple : adoxia_crm/public)"
    read FOLDER
    echo
  else
    FOLDER="$1"
fi

# Nom de domaine
DOMAIN=""
if [ -z "$2" ]
  then
    echo "Quel est le nom de domaine utilisé en local ? (exemple : adoxia_crm.docker)"
    read DOMAIN
    echo
  else
    DOMAIN="$2"
fi

CONF="${APACHE}${DOMAIN}.conf"
CONF_enabled="${APACHE_ENABLED}${DOMAIN}.conf"
CONF_SSL="${APACHE}${DOMAIN}-ssl.conf"
CONF_enabled_SSL="${APACHE_ENABLED}${DOMAIN}-ssl.conf"

rm "$CONF" 2> /dev/null
rm "$CONF_enabled" 2> /dev/null
rm "$CONF_SSL" 2> /dev/null
rm "$CONF_enabled_SSL" 2> /dev/null

cp "$TEMPLATE" "$CONF"
cp "$TEMPLATE_SSL" "$CONF_SSL"

FOLDER_ESCAPED=$(echo "$FOLDER" | sed "s#\/#\\\/#g")

sed -i "s/__path__/$FOLDER_ESCAPED/g" $CONF
sed -i "s/__domain__/$DOMAIN/g" $CONF
sed -i "s/__path__/$FOLDER_ESCAPED/g" $CONF_SSL
sed -i "s/__domain__/$DOMAIN/g" $CONF_SSL

a2ensite "${DOMAIN}.conf" > /dev/null
a2ensite "${DOMAIN}-ssl.conf" > /dev/null
service apache2 reload > /dev/null

echo -e "${GREEN}Site local $DOMAIN créée avec succès et associé au dossier $FOLDER !${NC}"
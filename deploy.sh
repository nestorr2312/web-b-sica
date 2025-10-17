#!/bin/bash
# Script de despliegue LAMP ultra-acortado

source .env
set -e

echo "Instalando LAMP y actualizando..."
sudo apt update && sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql -y
sudo ufw allow "Apache Full" && sudo ufw --force enable 

echo "Configurando DB y desplegando app..."
mysql -u root -e "CREATE DATABASE ${DB_NAME}; CREATE USER '${DB_USER}'@'localhost' IDENTIFIED BY '${DB_PASSWORD}'; GRANT ALL PRIVILEGES ON ${DB_NAME}.* TO '${DB_USER}'@'localhost'; FLUSH PRIVILEGES;"

sudo mkdir -p ${WEB_ROOT_PATH}
cp -r app/* ${WEB_ROOT_PATH}
sudo chown -R www-data:www-data ${WEB_ROOT_PATH}

echo "Configurando Virtual Host..."
VHOST_CONF="/etc/apache2/sites-available/${SERVER_NAME}.conf"
sudo bash -c "cat > ${VHOST_CONF} <<EOL
<VirtualHost *:80>
    ServerName ${SERVER_NAME}
    DocumentRoot ${WEB_ROOT_PATH}
</VirtualHost>
EOL"

sudo a2ensite ${SERVER_NAME}.conf
sudo a2dissite 000-default.conf
sudo systemctl restart apache2


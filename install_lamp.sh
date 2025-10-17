# Actualizar el sistema e instalar paquetes base
sudo apt update && sudo apt upgrade -y

# Instalación de los componentes de la pila LAMP
echo "Instalando Apache, MariaDB y PHP..."
sudo apt install apache2 mariadb-server php libapache2-mod-php php-mysql php-cli -y

# Configuración básica del firewall
sudo ufw allow "Apache Full"
sudo ufw --force enable

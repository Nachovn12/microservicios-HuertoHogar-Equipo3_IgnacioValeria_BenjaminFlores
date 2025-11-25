#!/bin/bash
#
# Script de inicialización para el nodo Manager de Docker Swarm en EC2
#

# 1. Actualizar el sistema e instalar dependencias
sudo apt-get update -y
sudo apt-get install -y apt-transport-https ca-certificates curl gnupg lsb-release

# 2. Instalar Docker
echo "--- Instalando Docker ---"
sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update -y
sudo apt-get install -y docker-ce docker-ce-cli containerd.io docker-compose-plugin

# 3. Añadir el usuario "ubuntu" al grupo docker
sudo usermod -aG docker ubuntu

# 4. Instalar Docker Compose (para despliegue de Stack)
echo "--- Instalando Docker Compose ---"
COMPOSE_VERSION="1.29.2" # Versión estable, se puede actualizar
sudo curl -L "https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# 5. Inicializar Docker Swarm (IMPORTANTE: Usar la IP Privada)
# Reemplazar la IP de abajo por el comando que obtenga la IP privada
echo "--- Inicializando Docker Swarm Manager ---"
# Este comando es placeholder. La IP real se debe obtener en el despliegue.
sudo docker swarm init --advertise-addr 10.0.0.100 

echo "Configuración de Docker Swarm Manager completada. El servicio está listo."
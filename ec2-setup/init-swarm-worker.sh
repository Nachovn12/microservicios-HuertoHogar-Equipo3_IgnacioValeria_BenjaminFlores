#!/bin/bash
#
# Script de inicialización para los nodos Worker de Docker Swarm en EC2
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

# 4. Nota: El nodo worker se unirá al Swarm después de que el Manager genere el token.
#    Este paso debe ejecutarse manualmente o automatizarse más tarde:

# echo "--- Uniéndose al Docker Swarm Worker ---"
# sudo docker swarm join --token <SWARM_TOKEN_GENERADO_POR_MANAGER> <MANAGER_IP>:2377

echo "Configuración de Docker Swarm Worker completada. Listo para unirse al clúster."
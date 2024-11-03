#!/bin/bash

# Mise à jour du système
echo "Mise à jour du système..."
sudo apt update && sudo apt upgrade -y

# Installation des paquets nécessaires
echo "Installation des paquets nécessaires..."
sudo apt install -y apt-transport-https ca-certificates curl software-properties-common

# Ajout de la clé GPG Docker et du dépôt Docker
echo "Ajout de la clé GPG et du dépôt Docker..."
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

# Mise à jour et installation de Docker
echo "Mise à jour des paquets et installation de Docker..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io

# Activer Docker
echo "Activation et démarrage de Docker..."
sudo systemctl enable docker
sudo systemctl start docker

# Installation de Docker Compose v2
echo "Installation de Docker Compose v2..."
DOCKER_COMPOSE_VERSION=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
sudo curl -L "https://github.com/docker/compose/releases/download/$DOCKER_COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose

# Vérification de l'installation
echo "Vérification des versions installées..."
docker --version
docker-compose --version && echo "Docker et Docker Compose v2 ont été installés avec succès."

# Ajouter l'utilisateur actuel au groupe docker
echo "Ajout de l'utilisateur $(whoami) au groupe Docker..."
sudo usermod -aG docker $(whoami)
newgrp docker
echo "Installation terminée. Déconnectez-vous et reconnectez-vous pour utiliser Docker sans sudo."

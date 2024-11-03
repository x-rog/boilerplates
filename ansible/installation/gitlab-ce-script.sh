#!/bin/bash

# Mettre à jour le système
sudo apt update && sudo apt upgrade -y

# Installer les dépendances requises
sudo apt install -y curl openssh-server ca-certificates tzdata

# Ajouter le dépôt GitLab
curl -sS https://packages.gitlab.com/install/repositories/gitlab/gitlab-ee/script.deb.sh | sudo bash

# Installer GitLab avec l'URL du domaine (remplacez par votre propre domaine)
sudo EXTERNAL_URL="http://gitlab.home.macloudconnect.com" apt install gitlab-ee -y

# Configurer GitLab
sudo gitlab-ctl reconfigure

# Vérifier le statut de GitLab
sudo gitlab-ctl status

echo "Installation de GitLab terminée. Accédez à votre serveur à l'adresse http://gitlab.example.com"

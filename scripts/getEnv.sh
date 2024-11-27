#!/bin/bash

# Charger les variables d'environnement
source .env

# Mettre à jour le statut du déploiement
RESPONSE=$(curl -L \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  "https://api.github.com/repos/$GITHUB_REPO/deployments?environment=$GITHUB_ENV")

echo "$RESPONSE"

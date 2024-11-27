#!/bin/bash

# Charger les variables d'env
source .env

# Variables
DEPLOYMENT_ID="$1"

# Verification des arguments
if [ -z "$DEPLOYMENT_ID" ]; then
  echo "Usage : $0 <deployment_id>"
  exit 1
fi

# Delete le deploiement
curl -L \
  -X DELETE \
  -H "Accept: application/vnd.github+json" \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "X-GitHub-Api-Version: 2022-11-28" \
  https://api.github.com/repos/$GITHUB_REPO/deployments/$DEPLOYMENT_ID

echo "Déploiement $DEPLOYMENT_ID a été supprimé"

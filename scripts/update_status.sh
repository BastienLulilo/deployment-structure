#!/bin/bash

# Charger les variables d'environnement
source .env

# Variables
DEPLOYMENT_ID="$1"
STATE="$2"

# Vérification des arguments
if [ -z "$DEPLOYMENT_ID" ] || [ -z "$STATE" ]; then
  echo "Usage : $0 <deployment_id> <state>"
  exit 1
fi

# Mettre à jour le statut du déploiement
curl -s -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/$GITHUB_REPO/deployments/$DEPLOYMENT_ID/statuses \
  -d @- <<EOF_JSON
{
  "state": "$STATE",
  "environment": "$GITHUB_ENV",
  "description": "Statut mis à jour vers $STATE"
}
EOF_JSON

echo "Statut mis à jour pour le déploiement $DEPLOYMENT_ID avec l'état $STATE."

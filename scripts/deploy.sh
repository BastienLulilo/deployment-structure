#!/bin/bash

# Charger les variables d'environnement
source .env

# Variables
BRANCH="$1"
DESCRIPTION="Déploiement de la branche $BRANCH sur l'environnement test"

# Vérifier l'argument
if [ -z "$BRANCH" ]; then
  echo "Erreur : Veuillez fournir une branche."
  exit 1
fi

# Créer un déploiement via l'API GitHub
DEPLOYMENT_RESPONSE=$(curl -s -X POST \
  -H "Authorization: Bearer $GITHUB_TOKEN" \
  -H "Accept: application/vnd.github+json" \
  https://api.github.com/repos/$GITHUB_REPO/deployments \
  -d @- <<EOF_JSON
{
  "ref": "$BRANCH",
  "environment": "test",
  "description": "$DESCRIPTION",
  "required_contexts": [],
  "transient_environment": true,
  "auto_merge": false
}
EOF_JSON
)

DEPLOYMENT_ID=$(echo "$DEPLOYMENT_RESPONSE" | jq -r '.id')

if [ "$DEPLOYMENT_ID" == "null" ]; then
  echo "Erreur : Impossible de créer le déploiement."
  echo "$DEPLOYMENT_RESPONSE"
  exit 1
fi

echo "Déploiement créé avec succès : ID $DEPLOYMENT_ID"

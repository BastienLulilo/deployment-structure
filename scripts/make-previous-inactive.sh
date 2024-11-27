#!/bin/bash

# Variables pour les scripts à appeler
GET_ENV_SCRIPT="./scripts/getEnv.sh"
UPDATE_STATUS_SCRIPT="./scripts/update_status.sh"

# Fichier temporaire pour stocker la réponse
RESPONSE_FILE="response.json"

# Exécuter le script pour récupérer les données et les stocker dans le fichier
$GET_ENV_SCRIPT > "$RESPONSE_FILE"

# Vérifier si le fichier a bien été créé et contient des données
if [ ! -s "$RESPONSE_FILE" ]; then
    echo "Erreur : la réponse est vide ou le fichier n'a pas été créé."
    exit 1
fi

# Parcourir chaque ID dans la réponse JSON et exécuter le script de mise à jour
for id in $(jq -r '.[].id' "$RESPONSE_FILE"); do
    echo "Mise à jour du statut pour ID : $id"
    $UPDATE_STATUS_SCRIPT "$id" "inactive"
done

# Supprimer le fichier temporaire pour nettoyer
rm -f "$RESPONSE_FILE"

echo "Processus terminé avec succès."

# github-deployment-structure

Ce projet montre comment gérer les déploiements GitHub via des scripts.

## Pré-requis
Avoir le paquet JQ pour la question de json installé
```bash
apt get install jq
```

## Scripts disponibles

### Déployer une branche
```bash
./scripts/deploy.sh <branch-name>
```

### Mettre à jour le statut d'un déploiement
Liste des status dispo : error, failure, inactive, in_progress, queued, pending, success
```bash
./scripts/update_status.sh <deployment_id> <state>
```

### Récupérer tous les déploiements
```bash
./scripts/get.sh
```

### Supprimer un déploiement
```bash
./scripts/clear_deployment.sh <deployment_id>
```

### Récupérer tous id de déploiement
```bash
./scripts/get.sh > response.json
jq '.[].id' response.json
```

### Boucle d'action sur les id de déploiement
Ici l'exemple, prend les ids, les met tous en inactif, puis les supprimes.
```bash
./scripts/get.sh > response.json
for id in $(jq -r '.[].id' response.json); do
    ./scripts/update_status.sh "$id" "inactive"
    ./scripts/clear_deployment.sh "$id"
done
```

## Configuration
Créez un fichier `.env` avec les variables suivantes :
- `GITHUB_TOKEN` : Votre token GitHub.
- `GITHUB_REPO` : Nom du dépôt au format `user/repo`.
- `GITHUB_ENV` : Nom de l'environnement
- `DEPLOYMENT_URL` : Url de l'environnement

## Exemple
```
GITHUB_TOKEN=ghp_votreToken
GITHUB_REPO=votre-username/deployment-structure
GITHUB_ENV=staging-1
DEPLOYMENT_URL="https://example.com"
```

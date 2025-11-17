# TP3 Docker - Starter Kit

API Express simple pour apprendre Docker et Docker Compose.

## Installation

```bash
cd app
npm install
```

## Lancer en Local

```bash
npm start
```

Ouvrir http://localhost:3000

## Structure

```
app/
├── server.js          # API Express avec 5 endpoints
├── package.json       # Dépendances
├── public/
│   └── index.html     # Interface web
└── .dockerignore      # Fichiers à exclure du build Docker
```

## Endpoints API

- `GET /` - Page d'accueil
- `GET /api/health` - Healthcheck
- `GET /api/info` - Informations système
- `GET /api/time` - Heure actuelle
- `GET /api/env` - Variables d'environnement
- `POST /api/echo` - Echo des données

## Prochaines Étapes

Suivez les instructions dans le README.md principal du TP pour:
1. Créer un Dockerfile
2. Builder l'image Docker
3. Créer un docker-compose.yml multi-services
4. (Bonus) Pousser vers Docker Hub

## Tests Rapides

```bash
# Healthcheck
curl http://localhost:3000/api/health

# Info système
curl http://localhost:3000/api/info

# Echo
curl -X POST http://localhost:3000/api/echo \
  -H "Content-Type: application/json" \
  -d '{"message":"Hello Docker"}'
```

**Formation**: M2 ESTD - Initiation DevOps - ForEach Academy

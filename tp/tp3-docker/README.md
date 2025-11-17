# TP3: Docker & Conteneurisation

**Durée**: 25 minutes
**Difficulté**: ⭐⭐⭐⭐☆
**Compétences**: C20 - Conteneurisation et orchestration

---

## 🎯 Objectifs

À la fin de ce TP, vous serez capable de:
- ✅ Créer un Dockerfile multi-stage optimisé
- ✅ Comprendre les layers et le caching Docker
- ✅ Builder et exécuter des images Docker
- ✅ Créer un docker-compose.yml multi-services
- ✅ Gérer les réseaux et volumes Docker
- ✅ Pousser une image vers un registre (Docker Hub / GHCR)

---

## 📋 Prérequis

- Docker Desktop installé et **démarré** (`docker --version`)
- Compte Docker Hub créé (https://hub.docker.com)
- Terminal / ligne de commande
- Le starter kit de l'application

---

## 🚀 Étape 1: Dockerfile Basique (8 minutes)

### 1.1 Explorer le starter kit

```bash
cd ~/Desktop/tp3-docker-starter/app
ls -la
```

Vous devez voir:
```
package.json
server.js
public/
  index.html
```

### 1.2 Tester l'application localement (optionnel)

```bash
npm install
npm start
```

Ouvrir http://localhost:3000 → Vous devez voir "Mon API DevOps"

Arrêter avec `Ctrl+C`.

### 1.3 Créer un Dockerfile basique

Créer `app/Dockerfile`:

```dockerfile
# Image de base
FROM node:20-alpine

# Répertoire de travail
WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer les dépendances
RUN npm ci --only=production

# Copier le code de l'application
COPY . .

# Exposer le port
EXPOSE 3000

# Commande de démarrage
CMD ["node", "server.js"]
```

### 1.4 Créer un .dockerignore

Créer `app/.dockerignore`:

```
node_modules
npm-debug.log
.env
.git
.gitignore
README.md
.dockerignore
```

### 1.5 Builder l'image

```bash
cd app
docker build -t mon-app:v1 .
```

Observer les étapes (layers) qui s'exécutent.

### 1.6 Lancer le conteneur

```bash
docker run -p 3000:3000 --name devops-app mon-app:v1
```

Ouvrir http://localhost:3000 → L'app doit fonctionner!

Arrêter avec `Ctrl+C` puis:
```bash
docker rm devops-app
```

### ✓ Point de Validation

```bash
# Lister les images
docker images

# Vérifier la taille
docker images mon-app:v1
```

Vous devez voir: `mon-app` version `v1` (~150-200MB)

---

## ⚡ Étape 2: Dockerfile Multi-Stage Optimisé (7 minutes)

### 2.1 Comprendre le problème

L'image v1 contient:
- ❌ npm, yarn (inutiles en production)
- ❌ Fichiers de build (package.json, etc.)
- ❌ Potentiellement des dépendances de dev

### 2.2 Créer un Dockerfile multi-stage

Modifier `app/Dockerfile`:

```dockerfile
# ==========================================
# Stage 1: Builder
# ==========================================
FROM node:20-alpine AS builder

WORKDIR /app

# Copier et installer toutes les dépendances
COPY package*.json ./
RUN npm ci --only=production

# Copier le code source
COPY . .

# ==========================================
# Stage 2: Production
# ==========================================
FROM node:20-alpine

WORKDIR /app

# Créer un utilisateur non-root pour la sécurité
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copier seulement les fichiers nécessaires depuis le builder
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/server.js ./
COPY --from=builder --chown=nodejs:nodejs /app/public ./public
COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

# Passer à l'utilisateur non-root
USER nodejs

# Exposer le port
EXPOSE 3000

# Healthcheck pour monitoring
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => process.exit(r.statusCode === 200 ? 0 : 1))"

# Commande de démarrage
CMD ["node", "server.js"]
```

### 2.3 Rebuild l'image

```bash
docker build -t mon-app:v2 .
```

### 2.4 Comparer les tailles

```bash
docker images | grep mon-app
```

Vous devriez voir:
- `mon-app:v1` → ~150-200MB
- `mon-app:v2` → ~120-150MB (plus petite!)

### 2.5 Tester la nouvelle image

```bash
docker run -p 3000:3000 --name devops-app-v2 mon-app:v2
```

Tester http://localhost:3000 → Doit fonctionner identiquement

```bash
# Arrêter et supprimer
docker stop devops-app-v2
docker rm devops-app-v2
```

### ✓ Point de Validation

- Image v2 est plus petite que v1
- Application fonctionne avec l'image v2
- Healthcheck configuré (visible avec `docker inspect`)

---

## 🎨 Étape 3: Docker Compose Multi-Services (7 minutes)

### 3.1 Créer docker-compose.yml

Créer `docker-compose.yml` à la racine du projet:

```yaml
version: '3.8'

services:
  app:
    build:
      context: ./app
      dockerfile: Dockerfile
    container_name: devops-app
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - REDIS_URL=redis://redis:6379
      - DATABASE_URL=postgres://devops:password@postgres:5432/devops_db
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_started
    networks:
      - app-network
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    container_name: devops-redis
    ports:
      - "6379:6379"
    volumes:
      - redis-data:/data
    networks:
      - app-network
    command: redis-server --appendonly yes
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    container_name: devops-postgres
    ports:
      - "5432:5432"
    environment:
      - POSTGRES_USER=devops
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=devops_db
    volumes:
      - postgres-data:/var/lib/postgresql/data
    networks:
      - app-network
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U devops"]
      interval: 10s
      timeout: 5s
      retries: 5
    restart: unless-stopped

  nginx:
    image: nginx:alpine
    container_name: devops-nginx
    ports:
      - "80:80"
    volumes:
      - ./nginx.conf:/etc/nginx/nginx.conf:ro
    depends_on:
      - app
    networks:
      - app-network
    restart: unless-stopped

networks:
  app-network:
    driver: bridge

volumes:
  redis-data:
  postgres-data:
```

### 3.2 Créer la configuration Nginx

Créer `nginx.conf`:

```nginx
events {
    worker_connections 1024;
}

http {
    upstream app_backend {
        server app:3000;
    }

    server {
        listen 80;
        server_name localhost;

        location / {
            proxy_pass http://app_backend;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Connection 'upgrade';
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
            proxy_set_header X-Real-IP $remote_addr;
            proxy_set_header X-Forwarded-For $proxy_add_x_forwarded_for;
        }
    }
}
```

### 3.3 Démarrer la stack complète

```bash
# Retourner à la racine
cd ..

# Démarrer tous les services
docker-compose up -d
```

Vous devez voir:
```
Creating network "tp3-docker_app-network" ... done
Creating volume "tp3-docker_redis-data" ... done
Creating volume "tp3-docker_postgres-data" ... done
Creating devops-redis ... done
Creating devops-postgres ... done
Creating devops-app ... done
Creating devops-nginx ... done
```

### 3.4 Vérifier que tout fonctionne

```bash
# Voir les conteneurs running
docker-compose ps

# Tous doivent être "Up" et healthy
```

Ouvrir http://localhost → Via nginx (port 80)
Ouvrir http://localhost:3000 → Direct app (port 3000)

### 3.5 Explorer les logs

```bash
# Logs de tous les services
docker-compose logs

# Logs d'un service spécifique
docker-compose logs app

# Suivre les logs en temps réel
docker-compose logs -f
```

### 3.6 Arrêter la stack

```bash
# Arrêter et supprimer les conteneurs
docker-compose down

# Avec suppression des volumes (données perdues!)
docker-compose down -v
```

### ✓ Point de Validation

- `docker-compose ps` montre 4 services "Up"
- http://localhost affiche l'app via nginx
- Logs accessibles pour chaque service
- Volumes persistent après restart

---

## 🎖️ Étape 4 (BONUS): Push vers Docker Hub (3 minutes)

### 4.1 Se connecter à Docker Hub

```bash
docker login
```

Entrer votre username et password Docker Hub.

### 4.2 Tagger l'image

```bash
# Format: username/repository:tag
docker tag mon-app:v2 VOTRE_USERNAME/mon-app-devops:v1.0.0
docker tag mon-app:v2 VOTRE_USERNAME/mon-app-devops:latest
```

### 4.3 Pousser vers Docker Hub

```bash
docker push VOTRE_USERNAME/mon-app-devops:v1.0.0
docker push VOTRE_USERNAME/mon-app-devops:latest
```

### 4.4 Vérifier sur Docker Hub

Aller sur https://hub.docker.com/r/VOTRE_USERNAME/mon-app-devops

Votre image doit être visible et téléchargeable publiquement!

### 4.5 Tester le pull depuis le registre

```bash
# Supprimer l'image locale
docker rmi VOTRE_USERNAME/mon-app-devops:latest

# Pull depuis Docker Hub
docker pull VOTRE_USERNAME/mon-app-devops:latest

# Run
docker run -p 3000:3000 VOTRE_USERNAME/mon-app-devops:latest
```

### ✓ Point de Validation

- Image visible sur Docker Hub
- Taille affichée (~120-150MB)
- Pull et run fonctionnent depuis le registre
- README Docker Hub mis à jour (optionnel)

---

## 📊 Vérification Complète

### Checklist Finale

```bash
# Vérifier les images
docker images

# Vérifier docker-compose
docker-compose config

# Démarrer la stack
docker-compose up -d

# Vérifier les services
docker-compose ps

# Tester l'application
curl http://localhost/api/health
curl http://localhost/api/info

# Voir les logs
docker-compose logs app

# Inspecter un conteneur
docker inspect devops-app

# Voir les volumes
docker volume ls

# Voir les réseaux
docker network ls
```

Vous devriez avoir:
- ✅ 2+ images Docker (mon-app:v1, mon-app:v2)
- ✅ 4 conteneurs running (app, redis, postgres, nginx)
- ✅ 2 volumes (redis-data, postgres-data)
- ✅ 1 réseau (app-network)
- ✅ Application accessible sur http://localhost
- ✅ (Bonus) Image poussée sur Docker Hub

---

## 🎓 Concepts Clés Appris

### Dockerfile Multi-Stage

```dockerfile
# Stage 1: Build dependencies
FROM node:20-alpine AS builder
RUN npm ci

# Stage 2: Production (copie seulement le nécessaire)
FROM node:20-alpine
COPY --from=builder /app/node_modules ./node_modules
```

**Avantages**:
- Images plus petites (~30-40% de réduction)
- Sécurité accrue (pas d'outils de build en prod)
- Build cache optimisé

### Docker Layers

Chaque instruction Dockerfile crée un layer:
```dockerfile
FROM node:20-alpine          # Layer 1
WORKDIR /app                 # Layer 2
COPY package*.json ./        # Layer 3
RUN npm ci                   # Layer 4
COPY . .                     # Layer 5
```

**Optimisation**: Mettre les layers qui changent rarement en premier (caching).

### Docker Compose

**Service** = Conteneur + configuration:
```yaml
services:
  app:
    build: ./app
    ports:
      - "3000:3000"
    depends_on:
      - postgres
```

**Réseau** = Communication inter-services:
- Services dans le même réseau peuvent se parler
- Résolution DNS automatique (nom du service = hostname)

**Volume** = Persistence des données:
- Named volumes gérés par Docker
- Survivent au `docker-compose down`

### Healthcheck

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s \
  CMD curl -f http://localhost:3000/health || exit 1
```

Permet à Docker/K8s de savoir si le conteneur est sain.

---

## 🧪 Tests Avancés (Pour les Rapides)

### Test 1: Inspecter les layers

```bash
# Voir l'historique de l'image
docker history mon-app:v2

# Analyser avec dive (outil externe)
# https://github.com/wagoodman/dive
dive mon-app:v2
```

### Test 2: Optimiser encore plus

Créer Dockerfile avec distroless:
```dockerfile
FROM node:20-alpine AS builder
# ... build steps

FROM gcr.io/distroless/nodejs20-debian11
COPY --from=builder /app .
CMD ["server.js"]
```

### Test 3: Ajouter Monitoring

Ajouter Prometheus + Grafana au docker-compose:
```yaml
  prometheus:
    image: prom/prometheus
    volumes:
      - ./prometheus.yml:/etc/prometheus/prometheus.yml

  grafana:
    image: grafana/grafana
    ports:
      - "3001:3000"
```

### Test 4: Scanner la sécurité

```bash
# Avec Trivy (installer depuis https://trivy.dev)
trivy image mon-app:v2

# Avec Docker Scout
docker scout cves mon-app:v2
```

---

## 🔗 Ressources

- [Docker Documentation](https://docs.docker.com/)
- [Dockerfile Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Docker Compose Documentation](https://docs.docker.com/compose/)
- [Multi-Stage Builds](https://docs.docker.com/build/building/multi-stage/)
- [Docker Hub](https://hub.docker.com/)

---

## ✅ Checklist de Complétion

### Dockerfile Basique (8 min)
- [ ] Dockerfile créé et syntaxiquement correct
- [ ] Image buildée avec succès
- [ ] Conteneur lance et app fonctionne
- [ ] .dockerignore configuré

### Optimisation Multi-Stage (7 min)
- [ ] Dockerfile multi-stage créé
- [ ] Image v2 plus petite que v1
- [ ] Utilisateur non-root configuré
- [ ] Healthcheck ajouté et fonctionnel

### Docker Compose (7 min)
- [ ] docker-compose.yml créé avec 4 services
- [ ] Réseaux et volumes configurés
- [ ] Stack complète démarre avec `docker-compose up`
- [ ] Tous les services sont "Up" et healthy
- [ ] Application accessible via nginx (port 80)

### Bonus (3 min)
- [ ] Image taguée correctement
- [ ] Push vers Docker Hub réussi
- [ ] Image téléchargeable publiquement
- [ ] Tests avancés réalisés

---

## 💡 Trucs et Astuces

### Commandes Docker Essentielles

```bash
# Images
docker images                    # Lister images
docker build -t name:tag .      # Builder
docker rmi name:tag             # Supprimer
docker prune -a                 # Nettoyer tout

# Conteneurs
docker ps                       # Lister running
docker ps -a                    # Lister tous
docker run -p 3000:3000 image  # Lancer
docker stop container_id        # Arrêter
docker rm container_id          # Supprimer
docker logs container_id        # Voir logs

# Docker Compose
docker-compose up -d            # Démarrer en background
docker-compose ps               # Statut services
docker-compose logs -f service  # Suivre logs
docker-compose down             # Arrêter tout
docker-compose restart service  # Redémarrer un service
```

### Débugger un Conteneur

```bash
# Exécuter une commande dans un conteneur running
docker exec -it devops-app sh

# Une fois dans le conteneur
ls -la
cat server.js
ps aux
exit
```

### Nettoyer Docker

```bash
# Supprimer conteneurs arrêtés
docker container prune

# Supprimer images inutilisées
docker image prune

# Supprimer volumes inutilisés
docker volume prune

# Tout nettoyer (ATTENTION!)
docker system prune -a --volumes
```

---

## 📊 Métriques à Observer

### Taille des Images

**Impact**:
- Temps de pull/push
- Espace disque
- Temps de démarrage
- Surface d'attaque sécurité

**Objectifs**:
- Node.js app: <200MB
- Avec multi-stage: <150MB
- Avec distroless: <100MB

### Temps de Build

**Sans cache**:
- Premier build: ~2-5 minutes

**Avec cache**:
- Rebuild sans changements: ~5-10 secondes
- Rebuild avec changement code: ~20-30 secondes

**Layers cachés** = builds ultra-rapides!

---

## 🏆 Critères de Réussite

Vous avez réussi le TP si:

1. ✅ Dockerfile multi-stage construit une image fonctionnelle
2. ✅ Image < 200MB
3. ✅ Docker Compose démarre 4 services avec succès
4. ✅ Application accessible via nginx sur port 80
5. ✅ Healthcheck fonctionne
6. ✅ Volumes persistent les données

**Score minimal**: 70/100 points (voir grille d'évaluation)

---

**Formateur**: Fabrice Claeys
**Formation**: M2 ESTD - Initiation DevOps
**ForEach Academy** - 2025

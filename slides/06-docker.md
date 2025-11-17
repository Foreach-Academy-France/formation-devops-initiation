---
marp: true
theme: default
paginate: true
header: 'Module 6: Docker & Conteneurisation'
footer: 'Cours DevOps - M2 ESTD | ForEach Academy | Nov 2025'
---

<!-- _class: lead -->

# Module 6
## Docker & Conteneurisation

**Formation DevOps - M2 ESTD Architecte Web**
ForEach Academy | Novembre 2025

---

## 📋 Plan du module (1h)

1. **Conteneurs vs VMs** (15min)
   - Histoire de la conteneurisation
   - Architecture comparée
   - Performance et use cases

2. **Docker Fondamentaux** (20min)
   - Architecture Docker
   - Images et layers
   - Dockerfile complet
   - Multi-stage builds

3. **Docker Compose & Production** (25min)
   - Docker Compose
   - Microservices
   - Best practices sécurité
   - Registres d'images

---

<!-- _class: lead -->

# 1. Conteneurs vs VMs

---

## Le problème avant Docker (années 2000)

**"It works on my machine!"** 😱

```
Développeur A (Mac)     → ✅ Fonctionne
Développeur B (Windows) → ❌ Crash
Serveur staging (Ubuntu) → ⚠️  Comportement différent
Production (RHEL)       → 💥 NE FONCTIONNE PAS
```

**Causes** :
- Versions de dépendances différentes
- Configuration système différente
- Variables d'environnement manquantes
- "Dependency hell"

---

## La solution : Conteneurisation

**Conteneur** = Package **complet** incluant :
- ✅ Application
- ✅ Dépendances (bibliothèques, runtime)
- ✅ Configuration
- ✅ Variables d'environnement

**Promesse** : "Si ça fonctionne dans un conteneur, ça fonctionnera partout."

```
Laptop développeur  → 🐳 Conteneur
Serveur staging     → 🐳 Même conteneur
Production          → 🐳 Même conteneur
```

---

## Timeline de la conteneurisation

```
1979  ─ chroot (Unix V7)
       │  Isolation basique du filesystem
       │
2000  ─ FreeBSD Jails
       │  Isolation de processus
       │
2004  ─ Solaris Zones
       │  Virtualisation OS-level
       │
2008  ─ LXC (Linux Containers)
       │  Premier système de conteneurs Linux moderne
       │
2013  ─ Docker 🚀
       │  Solomon Hykes (dotCloud)
       │  Révolution : conteneurs accessibles à tous
       │
2014  ─ Kubernetes (Google)
       │  Orchestration de conteneurs à grande échelle
```

---

## Conteneurs vs VMs - Architecture

```
┌─────────────────────────────────────────────────────────────┐
│              VIRTUAL MACHINES (VMs)                          │
└─────────────────────────────────────────────────────────────┘

  ┌─────────┐  ┌─────────┐  ┌─────────┐
  │  App 1  │  │  App 2  │  │  App 3  │
  ├─────────┤  ├─────────┤  ├─────────┤
  │Guest OS │  │Guest OS │  │Guest OS │  ← OS complet (1-2 GB)
  │(Ubuntu) │  │(CentOS) │  │(Windows)│
  └─────────┘  └─────────┘  └─────────┘
       └───────────┬────────────┘
            ┌──────▼────────┐
            │  Hypervisor   │ ← VMware, KVM, Hyper-V
            └───────────────┘
            ┌───────────────┐
            │   Host OS     │
            └───────────────┘
            ┌───────────────┐
            │   Hardware    │
            └───────────────┘
```

---

## Conteneurs - Architecture

```
┌─────────────────────────────────────────────────────────────┐
│                     CONTAINERS                               │
└─────────────────────────────────────────────────────────────┘

  ┌─────────┐  ┌─────────┐  ┌─────────┐
  │  App 1  │  │  App 2  │  │  App 3  │
  ├─────────┤  ├─────────┤  ├─────────┤
  │  Libs   │  │  Libs   │  │  Libs   │  ← Pas d'OS complet
  └─────────┘  └─────────┘  └─────────┘
       └───────────┬────────────┘
            ┌──────▼────────┐
            │Docker Engine  │ ← containerd + runc
            └───────────────┘
            ┌───────────────┐
            │   Host OS     │ ← 1 seul OS partagé
            └───────────────┘
            ┌───────────────┐
            │   Hardware    │
            └───────────────┘
```

---

## Conteneurs vs VMs - Comparaison

| Critère | **VMs** | **Conteneurs** |
|---------|---------|----------------|
| **Isolation** | Complète (hypervisor) | OS-level (namespaces) |
| **Boot time** | 30-120 secondes | < 1 seconde |
| **Taille** | 1-10 GB par VM | 50-500 MB par conteneur |
| **Overhead** | ~10% CPU/RAM | ~2% CPU/RAM |
| **Densité** | 10-20 VMs/serveur | 100-1000 conteneurs/serveur |
| **Portabilité** | Limitée | Excellente |
| **Use case** | Isolation forte, multi-OS | Microservices, CI/CD |

---

## Quand utiliser VMs vs Conteneurs ?

**Virtual Machines** :
- ✅ Isolation **totale** requise (sécurité max)
- ✅ Multi-OS (Windows + Linux sur même host)
- ✅ Applications legacy non-conteneurisables

**Conteneurs** :
- ✅ **Microservices** (100+ services)
- ✅ **CI/CD** (build/test rapides)
- ✅ **Scalabilité** (scale out facile)
- ✅ **Portabilité** (dev → prod identique)

**Pattern moderne** : VMs pour l'infra de base + conteneurs pour les applications.

---

## Docker - La révolution (2013)

**Solomon Hykes** (dotCloud, YC W10) lance Docker en mars 2013.

**Innovation** : Rendre les conteneurs **simples** et **accessibles** à tous.

**Adoption explosive** :
- 2013 : 1,000 téléchargements
- 2014 : 1 million de pulls
- 2024 : **18 millions** d'images, **100M+** pulls/jour

**Pourquoi Docker a gagné** :
- ✅ CLI intuitive (`docker run`, `docker build`)
- ✅ Dockerfile standardisé
- ✅ Docker Hub (registry public)
- ✅ Écosystème riche (Compose, Swarm, Kubernetes)

---

<!-- _class: lead -->

# 2. Docker Fondamentaux

---

## Architecture Docker

```
┌─────────────────────────────────────────────────────────┐
│                  DOCKER ARCHITECTURE                     │
└─────────────────────────────────────────────────────────┘

   Docker CLI (client)
        │
        │ API REST
        ▼
   Docker Daemon (dockerd)
        │
        ├─> containerd (high-level runtime)
        │        │
        │        └─> runc (OCI runtime)
        │                 │
        │                 └─> Conteneurs Linux
        │
        └─> Images, Networks, Volumes
```

**Commandes de base** :
```bash
docker run nginx        # Créer et démarrer conteneur
docker ps               # Lister conteneurs actifs
docker images           # Lister images
docker logs <id>        # Voir les logs
```

---

## Images Docker et Layers

**Image** = Template immuable pour créer des conteneurs.

**Système de layers** (couches) :

```
┌────────────────────────────────────┐
│  Container Layer (Read-Write)     │ ← Modifications runtime
├────────────────────────────────────┤
│  Layer 4: COPY app/ /app/          │
├────────────────────────────────────┤
│  Layer 3: RUN npm install          │
├────────────────────────────────────┤
│  Layer 2: WORKDIR /app             │
├────────────────────────────────────┤
│  Layer 1: FROM node:20-alpine      │ ← Base image (read-only)
└────────────────────────────────────┘
```

**Avantages** :
- 🚀 **Réutilisation** : Layers partagés entre images
- 💾 **Économie** : 1 base ubuntu:22.04 pour 10 images
- ⚡ **Cache** : Layers inchangés ne se rebuild pas

---

## Dockerfile - Structure de base

```dockerfile
# Image de base
FROM node:20-alpine

# Répertoire de travail
WORKDIR /app

# Copier package.json
COPY package*.json ./

# Installer dépendances
RUN npm ci --only=production

# Copier code source
COPY . .

# Port exposé
EXPOSE 3000

# Commande de démarrage
CMD ["node", "server.js"]
```

---

## Instructions Dockerfile essentielles

```dockerfile
# FROM : Image de base
FROM node:20-alpine

# RUN : Exécuter commande pendant le build
RUN apk add --no-cache curl

# COPY : Copier fichiers locaux → image
COPY src/ /app/src/

# ADD : Comme COPY + décompresse archives
ADD https://example.com/file.tar.gz /tmp/

# WORKDIR : Définir répertoire de travail
WORKDIR /app

# ENV : Variables d'environnement
ENV NODE_ENV=production

# EXPOSE : Documenter le port
EXPOSE 3000

# CMD : Commande par défaut (overridable)
CMD ["node", "server.js"]

# ENTRYPOINT : Point d'entrée fixe
ENTRYPOINT ["docker-entrypoint.sh"]
```

---

## CMD vs ENTRYPOINT

**CMD** : Commande par défaut (peut être overridée)

```dockerfile
CMD ["node", "server.js"]
```

```bash
docker run myapp                    # Lance: node server.js
docker run myapp node debug.js      # Lance: node debug.js (CMD overridé)
```

**ENTRYPOINT** : Point d'entrée fixe

```dockerfile
ENTRYPOINT ["node"]
CMD ["server.js"]
```

```bash
docker run myapp                    # Lance: node server.js
docker run myapp debug.js           # Lance: node debug.js
```

**Pattern combiné recommandé** : ENTRYPOINT fixe + CMD par défaut.

---

## Best Practices Dockerfile

### ❌ Mauvais

```dockerfile
FROM node:20
COPY . /app
WORKDIR /app
RUN npm install
CMD ["node", "server.js"]
```

**Problèmes** :
- Image lourde (node:20 = 900 MB)
- Cache non optimisé
- Exécution en root (sécurité)
- Inclut node_modules/ et .git/

---

## Best Practices Dockerfile (suite)

### ✅ Bon

```dockerfile
FROM node:20-alpine                    # Image légère (150 MB)

RUN addgroup -g 1001 nodejs && \
    adduser -S nodejs -u 1001          # Utilisateur non-root

WORKDIR /app

COPY package*.json ./                  # Cache layer dépendances
RUN npm ci --only=production && \
    npm cache clean --force

COPY --chown=nodejs:nodejs . .         # Copier avec ownership

USER nodejs                            # Exécuter en non-root

EXPOSE 3000

CMD ["node", "server.js"]
```

**+ .dockerignore** pour exclure node_modules/, .git/, etc.

---

## Multi-stage Builds

**Problème** : Image de build contient des outils inutiles en prod.

```dockerfile
# ===== STAGE 1: Builder =====
FROM node:20 AS builder
WORKDIR /build
COPY package*.json ./
RUN npm install                    # Inclut devDependencies
COPY . .
RUN npm run build                  # Compile TypeScript

# ===== STAGE 2: Production =====
FROM node:20-alpine AS production
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production       # Production deps uniquement
COPY --from=builder /build/dist ./dist
USER node
CMD ["node", "dist/server.js"]
```

**Résultat** : 1.2 GB → 150 MB (87% de réduction) 🚀

---

## Multi-stage avec Go (image minimale)

```dockerfile
# ===== STAGE 1: Build =====
FROM golang:1.21-alpine AS builder
WORKDIR /build
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -o app .

# ===== STAGE 2: Runtime =====
FROM scratch                       # Image vide (0 MB!)
COPY --from=builder /build/app /app
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/
EXPOSE 8080
ENTRYPOINT ["/app"]
```

**Résultat** : Image de **5-10 MB** seulement ! 🤯

---

## Build et Run d'une image

```bash
# Build image avec tag
docker build -t myapp:1.0 .

# Run conteneur
docker run -d \
  --name myapp-container \
  -p 3000:3000 \
  -e NODE_ENV=production \
  myapp:1.0

# Vérifier logs
docker logs myapp-container

# Arrêter conteneur
docker stop myapp-container

# Supprimer conteneur
docker rm myapp-container
```

---

## Commandes Docker essentielles

```bash
# Images
docker images                      # Lister images locales
docker pull nginx:alpine           # Télécharger image
docker rmi nginx:alpine            # Supprimer image
docker build -t app:1.0 .          # Builder image

# Conteneurs
docker ps                          # Conteneurs actifs
docker ps -a                       # Tous les conteneurs
docker run -d nginx                # Démarrer conteneur (detached)
docker exec -it <id> /bin/sh       # Shell interactif
docker logs <id>                   # Logs
docker stop <id>                   # Arrêter
docker rm <id>                     # Supprimer

# Nettoyage
docker system prune -a             # Nettoyer tout (images, conteneurs, networks)
```

---

<!-- _class: lead -->

# 3. Docker Compose & Production

---

## Docker Compose - Qu'est-ce que c'est ?

**Problème** : Applications multi-conteneurs complexes à gérer.

**Solution** : Docker Compose = Orchestration **locale** de plusieurs conteneurs.

**Fichier** : `docker-compose.yml` (YAML déclaratif)

**Use cases** :
- ✅ Environnement de dev local (app + db + redis + maildev)
- ✅ Tests d'intégration
- ✅ Démos et prototypes

**Commandes** :
```bash
docker compose up -d        # Démarrer tous les services
docker compose down         # Arrêter et supprimer
docker compose logs -f      # Voir les logs
```

---

## Exemple docker-compose.yml

```yaml
version: '3.9'

services:
  web:
    build: .
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=development
      - DATABASE_URL=postgresql://postgres:password@db:5432/myapp
    depends_on:
      - db
      - redis
    volumes:
      - ./src:/app/src  # Hot reload

  db:
    image: postgres:16-alpine
    environment:
      - POSTGRES_PASSWORD=password
      - POSTGRES_DB=myapp
    volumes:
      - postgres-data:/var/lib/postgresql/data

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"

volumes:
  postgres-data:
```

---

## Architecture Microservices

**Monolithe** : Application unique contenant tout.

```
┌─────────────────────────────────┐
│        MONOLITHE                │
│                                 │
│  ┌──────────────────────────┐  │
│  │  Frontend                │  │
│  ├──────────────────────────┤  │
│  │  Business Logic          │  │
│  ├──────────────────────────┤  │
│  │  Database Access         │  │
│  └──────────────────────────┘  │
│                                 │
│  1 base de données              │
└─────────────────────────────────┘
```

**Problèmes** :
- ❌ Scalabilité limitée (tout ou rien)
- ❌ Déploiement risqué (tout redémarre)
- ❌ Équipes bloquées (merge conflicts)

---

## Microservices

**Microservices** : Application décomposée en **services indépendants**.

```
┌────────────┐  ┌────────────┐  ┌────────────┐
│  Frontend  │  │   Auth     │  │  Payment   │
│  (React)   │  │  Service   │  │  Service   │
└─────┬──────┘  └─────┬──────┘  └─────┬──────┘
      │               │               │
      └───────────────┼───────────────┘
                      │
              ┌───────▼────────┐
              │  API Gateway   │
              └────────────────┘
                      │
      ┌───────────────┼───────────────┐
      │               │               │
┌─────▼──────┐  ┌─────▼──────┐  ┌─────▼──────┐
│   User     │  │   Order    │  │  Inventory │
│  Service   │  │  Service   │  │  Service   │
└────────────┘  └────────────┘  └────────────┘
      │               │               │
  [User DB]      [Order DB]     [Inventory DB]
```

---

## Avantages Microservices

**Avantages** :
- ✅ **Scalabilité indépendante** (scale que les services nécessaires)
- ✅ **Déploiement indépendant** (1 service = 0 downtime pour les autres)
- ✅ **Technologie flexible** (Node.js + Go + Python + Java)
- ✅ **Équipes autonomes** (1 équipe = 1 service)
- ✅ **Résilience** (1 service down ≠ app down)

**Inconvénients** :
- ❌ Complexité opérationnelle (monitoring, logs distribués)
- ❌ Communication réseau (latence, fiabilité)
- ❌ Transactions distribuées (difficiles)
- ❌ Débogage complexe

**Recommandation** : Commencer monolithe → microservices quand nécessaire.

---

## Exemples Microservices (monde réel)

**Netflix** :
- **700+ microservices**
- **4000+ déploiements/jour**
- Chaque service = équipe autonome
- Stack : Java/Spring Boot, Node.js, Python

**Uber** :
- **2200+ microservices**
- 40,000 requêtes/seconde
- Go, Node.js, Java

**Amazon** :
- Pionnier (depuis 2001)
- "Two-pizza teams" (≤ 10 personnes/équipe)
- Chaque équipe = 1-3 microservices

---

## Best Practices Docker - Sécurité

### 1. Non-root user

```dockerfile
# ❌ Dangereux : exécution en root
FROM node:20-alpine
COPY . /app
CMD ["node", "server.js"]

# ✅ Sécurisé : utilisateur non-root
FROM node:20-alpine
RUN addgroup -g 1001 nodejs && adduser -S nodejs -u 1001
USER nodejs
COPY --chown=nodejs:nodejs . /app
CMD ["node", "server.js"]
```

### 2. Scanner les vulnérabilités

```bash
# Trivy
trivy image myapp:latest

# Snyk
snyk container test myapp:latest
```

---

## Best Practices Docker - Optimisation

### 1. Images légères

```dockerfile
# ❌ 900 MB
FROM node:20

# ✅ 150 MB
FROM node:20-alpine

# ✅✅ 50 MB (distroless)
FROM gcr.io/distroless/nodejs20-debian12
```

### 2. .dockerignore

```.dockerignore
node_modules/
.git/
*.md
.env
tests/
```

### 3. Cache layers

```dockerfile
# ✅ Copier package.json d'abord (cache optimal)
COPY package*.json ./
RUN npm ci
COPY . .
```

---

## Registres d'images

**Docker Hub** (public) :
- 18 millions d'images
- Gratuit : 200 pulls/6h
- Rate limits depuis 2020

**GitHub Container Registry (GHCR)** :
- `ghcr.io/username/image:tag`
- Gratuit et illimité (public)
- Intégré GitHub Actions

**Registres Cloud** :
- AWS ECR
- Google Artifact Registry
- Azure Container Registry

**Self-hosted** :
- Harbor (CNCF)

---

## Push vers GHCR (GitHub Actions)

```yaml
name: Build and Push

on:
  push:
    branches: [main]

jobs:
  build:
    runs-on: ubuntu-latest
    permissions:
      contents: read
      packages: write

    steps:
      - uses: actions/checkout@v4

      - name: Login to GHCR
        uses: docker/login-action@v3
        with:
          registry: ghcr.io
          username: ${{ github.actor }}
          password: ${{ secrets.GITHUB_TOKEN }}

      - name: Build and push
        uses: docker/build-push-action@v5
        with:
          push: true
          tags: ghcr.io/${{ github.repository }}:latest
```

---

## Docker en Production

**Orchestrateurs** (déploiement à grande échelle) :

1. **Kubernetes** (K8s)
   - Standard de facto
   - Gère 1000+ conteneurs
   - Auto-scaling, self-healing
   - Courbe d'apprentissage élevée

2. **Docker Swarm**
   - Intégré Docker
   - Plus simple que K8s
   - Moins de features

3. **Nomad** (HashiCorp)
   - Alternative légère
   - Multi-workload (Docker + VMs + binaires)

---

## Networking Docker

```bash
# Réseau bridge (par défaut)
docker network create mynetwork

# Connecter conteneurs
docker run --network mynetwork --name db postgres
docker run --network mynetwork --name web myapp

# Communication : web peut accéder à db via hostname "db"
```

**Types de networks** :
- `bridge` : Réseau isolé (défaut)
- `host` : Partage réseau host (performance)
- `none` : Pas de réseau

---

## Volumes Docker (Persistent Storage)

```bash
# Named volume (géré par Docker)
docker volume create mydata
docker run -v mydata:/data postgres

# Bind mount (dossier host)
docker run -v /host/path:/container/path nginx

# tmpfs (RAM, non-persistant)
docker run --tmpfs /tmp nginx
```

**Best practice** : Utiliser **named volumes** en production.

---

<!-- _class: lead -->

# 🎯 TP Pratique (25min)

## Conteneuriser une Application Web

---

## Objectifs du TP

**Créer une application conteneurisée complète** :

1. ✅ Écrire un Dockerfile optimisé (multi-stage)
2. ✅ Créer un .dockerignore
3. ✅ Builder l'image
4. ✅ Lancer le conteneur
5. ✅ Créer un docker-compose.yml (app + database)
6. ✅ Tester l'application complète
7. ✅ (Bonus) Push vers GitHub Container Registry

**Durée** : 25 minutes
**Support** : [Lien vers repo starter]

---

## Récapitulatif Module 6

**Conteneurs vs VMs** :
- VMs : Isolation complète, lourdes (1-10 GB)
- Conteneurs : Légers (50-500 MB), boot < 1s, densité 100x

**Docker** :
- Architecture : CLI → Daemon → containerd → runc
- Images en layers (réutilisation, cache)
- Dockerfile : FROM, RUN, COPY, CMD, ENTRYPOINT
- Multi-stage builds : réduction 87% taille

**Production** :
- Docker Compose pour orchestration locale
- Microservices : scalabilité, indépendance
- Sécurité : non-root, scanning (Trivy, Snyk)
- Registres : Docker Hub, GHCR, ECR, Harbor

---

<!-- _class: lead -->

# Questions ?

**Module 6 : Docker & Conteneurisation**

---

## 📚 Ressources Complémentaires

### Documentation
- **Docker Documentation** : https://docs.docker.com/
- **Dockerfile Best Practices** : https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
- **Docker Compose** : https://docs.docker.com/compose/

### Outils
- **Trivy** : https://trivy.dev/ (scanning vulnérabilités)
- **Hadolint** : https://github.com/hadolint/hadolint (linter Dockerfile)
- **Dive** : https://github.com/wagoodman/dive (analyse layers)

### Registres
- **Docker Hub** : https://hub.docker.com/
- **GHCR** : https://docs.github.com/en/packages

### Documents de recherche
- **recherche-docker-conteneurisation-partie1.md** (Histoire, VMs vs Conteneurs)
- **recherche-docker-conteneurisation-partie2.md** (Architecture, Dockerfile, Registres)

---

<!-- _class: lead -->

# Prochaine étape

## Module 7
### Autres Outils DevOps
*IaC, Kubernetes, Monitoring*

*Pause ☕ 15 minutes*

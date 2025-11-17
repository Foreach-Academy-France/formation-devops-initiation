---
claude-context: true
type: resource
category: formation
project: Cours Initiation DevOps
tags:
  - docker
  - containers
  - devops
  - architecture
  - images
  - dockerfile
created: 2025-11-05
---

# Docker & Conteneurisation - Partie 2
## Architecture Docker, Images, Dockerfile et Registres

> **Document de recherche pour le Module 6 du cours DevOps**
> *Formation M2 ESTD - Architecte Web | ForEach Academy | Novembre 2025*

---

## 📋 Table des matières (Partie 2)

1. [Architecture Docker Détaillée](#architecture-docker-détaillée)
2. [Images Docker et Système de Layers](#images-docker-et-système-de-layers)
3. [Dockerfile Complet](#dockerfile-complet)
4. [Multi-stage Builds](#multi-stage-builds)
5. [Registres d'Images](#registres-dimages)
6. [.dockerignore](#dockerignore)
7. [Références](#références)

---

## Architecture Docker Détaillée

### Vue d'ensemble

Docker utilise une **architecture client-serveur** :

```
┌─────────────────────────────────────────────────────────┐
│                    DOCKER ARCHITECTURE                   │
└─────────────────────────────────────────────────────────┘

    ┌──────────────┐
    │  Docker CLI  │  ← Interface utilisateur (commandes docker)
    └──────┬───────┘
           │ API REST (HTTP/Unix socket)
           │
    ┌──────▼────────────────────────────────────────────┐
    │            Docker Daemon (dockerd)                │
    │  ┌────────────────────────────────────────────┐  │
    │  │  API Server (gère les requêtes)           │  │
    │  └────────────────────────────────────────────┘  │
    │  ┌────────────────────────────────────────────┐  │
    │  │  containerd (runtime haut niveau)         │  │
    │  │  - Lifecycle containers                    │  │
    │  │  - Image management                        │  │
    │  │  - Network/Storage                         │  │
    │  └──────────────┬─────────────────────────────┘  │
    │                 │                                  │
    │  ┌──────────────▼─────────────────────────────┐  │
    │  │  runc (runtime bas niveau OCI)            │  │
    │  │  - Crée les conteneurs Linux              │  │
    │  │  - Namespaces, cgroups, capabilities      │  │
    │  └────────────────────────────────────────────┘  │
    └─────────────────────────────────────────────────────┘
                     │
         ┌───────────┴───────────┐
         │                       │
    ┌────▼─────┐          ┌─────▼────┐
    │Container1│          │Container2│
    │  nginx   │          │  postgres│
    └──────────┘          └──────────┘
```

### Composants clés

#### Docker CLI (Command Line Interface)

**Rôle** : Interface utilisateur pour interagir avec Docker Daemon.

```bash
# Exemples de commandes
docker run nginx
docker build -t myapp:1.0 .
docker ps
docker logs container_id
```

**Communication** :
- Unix socket : `/var/run/docker.sock` (local)
- TCP : `tcp://localhost:2375` (réseau)

#### Docker Daemon (dockerd)

**Rôle** : Serveur principal qui :
- Écoute les requêtes de l'API Docker
- Gère les images, conteneurs, networks, volumes
- Orchestre containerd et runc

**Processus** :
```bash
ps aux | grep dockerd
# /usr/bin/dockerd -H fd:// --containerd=/run/containerd/containerd.sock
```

#### containerd

**Rôle** : Runtime de **haut niveau** (extraction depuis Docker en 2016).

**Responsabilités** :
- Lifecycle des conteneurs (start, stop, pause, delete)
- Image pull/push
- Gestion du stockage et réseau
- Supervise runc

**Projet** : CNCF (Cloud Native Computing Foundation) - Graduated project (2019)

**Utilisation** :
```bash
# Commande containerd directe
ctr images pull docker.io/library/nginx:alpine
ctr run docker.io/library/nginx:alpine nginx1
```

#### runc

**Rôle** : Runtime de **bas niveau** conforme **OCI** (Open Container Initiative).

**Responsabilités** :
- Créer les conteneurs Linux
- Configurer les **namespaces** (isolation)
- Configurer les **cgroups** (limits CPU/RAM)
- Configurer les **capabilities** (permissions)

**Spécification OCI** :
```json
{
  "ociVersion": "1.0.0",
  "process": {
    "terminal": true,
    "user": { "uid": 0, "gid": 0 },
    "args": ["/bin/sh"]
  },
  "root": {
    "path": "rootfs",
    "readonly": true
  },
  "linux": {
    "namespaces": [
      { "type": "pid" },
      { "type": "network" },
      { "type": "mount" }
    ]
  }
}
```

### Flow d'exécution d'un conteneur

```
1. docker run nginx
         │
         ▼
2. Docker CLI → API REST → Docker Daemon
         │
         ▼
3. Daemon vérifie si image "nginx" existe localement
         │
         ▼
4. Si non, pull depuis Docker Hub
         │
         ▼
5. Daemon demande à containerd de créer le conteneur
         │
         ▼
6. containerd appelle runc avec la spécification OCI
         │
         ▼
7. runc crée les namespaces, cgroups, et lance le processus
         │
         ▼
8. Conteneur démarre (PID 1 = nginx)
```

---

## Images Docker et Système de Layers

### Qu'est-ce qu'une image Docker ?

Une **image Docker** est un **template immuable** contenant :
- Système de fichiers (binaires, bibliothèques, fichiers)
- Métadonnées (CMD, ENTRYPOINT, ENV, etc.)
- Historique des layers

**Propriétés** :
- ✅ **Immuable** : Une fois créée, ne change jamais
- ✅ **Versionnée** : Identifiée par digest SHA256
- ✅ **Portable** : Fonctionne partout (Linux, Windows, macOS avec Docker Desktop)
- ✅ **Composable** : Construite à partir de layers empilés

### Système de Layers (Layered Filesystem)

Chaque instruction dans un Dockerfile crée un **layer** (couche) :

```dockerfile
FROM ubuntu:22.04          # Layer 1 (base)
RUN apt-get update         # Layer 2
RUN apt-get install nginx  # Layer 3
COPY index.html /var/www/  # Layer 4
CMD ["nginx"]              # Metadata (pas un layer FS)
```

**Visualisation** :

```
┌────────────────────────────────────┐
│  Container Layer (Read-Write)     │ ← Modifications runtime
├────────────────────────────────────┤
│  Layer 4: COPY index.html          │
├────────────────────────────────────┤
│  Layer 3: RUN apt install nginx    │
├────────────────────────────────────┤
│  Layer 2: RUN apt-get update       │
├────────────────────────────────────┤
│  Layer 1: FROM ubuntu:22.04        │ ← Base image (read-only)
└────────────────────────────────────┘
```

**Avantages** :
- 🚀 **Réutilisation** : Layers partagés entre images
- 💾 **Économie d'espace** : Une base ubuntu:22.04 pour 10 images
- ⚡ **Pull rapide** : Télécharge uniquement les layers manquants
- 🔄 **Cache build** : Layers inchangés ne se rebuild pas

### Union Filesystems

Les **union filesystems** permettent de **superposer** plusieurs layers read-only + 1 layer read-write.

#### OverlayFS (moderne, performant)

**Le plus utilisé depuis Docker 1.13 (2017)** :

```bash
docker info | grep "Storage Driver"
# Storage Driver: overlay2
```

**Architecture** :

```
/var/lib/docker/overlay2/
├── l/  (symlinks)
├── 4a2f.../
│   ├── diff/       ← Contenu du layer
│   ├── link        ← Symlink court
│   └── lower       ← Layers parents
└── abcd.../
    ├── diff/
    ├── merged/     ← Vue unifiée (mount point)
    ├── work/       ← Espace de travail
    └── upper/      ← Container layer (RW)
```

**Montage** :
```bash
mount -t overlay overlay \
  -o lowerdir=/l1:/l2:/l3,upperdir=/upper,workdir=/work \
  /merged
```

#### Copy-on-Write (CoW)

**Comportement** :
1. Lecture d'un fichier → depuis le layer le plus haut
2. Modification d'un fichier → **copie** dans le container layer (upper)
3. Suppression → marquer comme "whiteout" (fichier .wh.filename)

**Exemple** :

```
Initial:
  Layer 3: /app/config.json (read-only)

Modification dans conteneur:
  Container Layer: /app/config.json (copie modifiée, read-write)

Résultat:
  Le fichier dans Layer 3 reste intact
  La version modifiée masque l'originale
```

### Image Manifest et Digest

Chaque image a un **manifest** (JSON) :

```json
{
  "schemaVersion": 2,
  "mediaType": "application/vnd.docker.distribution.manifest.v2+json",
  "config": {
    "mediaType": "application/vnd.docker.container.image.v1+json",
    "size": 1472,
    "digest": "sha256:abc123..."
  },
  "layers": [
    {
      "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
      "size": 2814446,
      "digest": "sha256:layer1..."
    },
    {
      "mediaType": "application/vnd.docker.image.rootfs.diff.tar.gzip",
      "size": 528,
      "digest": "sha256:layer2..."
    }
  ]
}
```

**Digest SHA256** : Identifiant unique et immuable de l'image.

```bash
docker pull nginx@sha256:4c0fdaa8b6341bfdeca5f18f7837462c80cff90527ee35ef185571e1c327beac
```

---

## Dockerfile Complet

### Structure de base

```dockerfile
# Syntaxe: INSTRUCTION arguments

FROM node:20-alpine                    # Image de base
WORKDIR /app                           # Répertoire de travail
COPY package*.json ./                  # Copier fichiers
RUN npm install                        # Exécuter commande
COPY . .                               # Copier code source
EXPOSE 3000                            # Port exposé
CMD ["node", "server.js"]              # Commande de démarrage
```

### Instructions détaillées

#### FROM - Image de base

```dockerfile
# Format: FROM [--platform=<platform>] <image>[:<tag>] [AS <name>]

FROM node:20-alpine
FROM ubuntu:22.04
FROM scratch                # Image vide (pour binaires statiques)
FROM --platform=linux/amd64 nginx:alpine  # Architecture spécifique
```

**Best practices** :
- ✅ Utiliser des tags **spécifiques** (`node:20-alpine` > `node:latest`)
- ✅ Préférer les images **alpine** (légères : 5-50 MB)
- ✅ Vérifier les images officielles sur Docker Hub

#### RUN - Exécuter des commandes

```dockerfile
# Shell form (exécuté avec /bin/sh -c)
RUN apt-get update && apt-get install -y curl

# Exec form (recommandé, pas de shell)
RUN ["apt-get", "update"]
RUN ["apt-get", "install", "-y", "curl"]
```

**Best practices** :
```dockerfile
# ❌ Mauvais : Crée 3 layers
RUN apt-get update
RUN apt-get install -y curl
RUN apt-get clean

# ✅ Bon : 1 seul layer
RUN apt-get update && \
    apt-get install -y curl && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*
```

#### COPY vs ADD

**COPY** : Copie simple (recommandé)

```dockerfile
COPY package.json /app/
COPY src/ /app/src/
COPY --chown=node:node . /app  # Définir ownership
```

**ADD** : Copie avec fonctionnalités supplémentaires

```dockerfile
ADD https://example.com/file.tar.gz /tmp/  # Télécharge depuis URL
ADD archive.tar.gz /app/                    # Décompresse automatiquement
```

**Recommandation** : Utiliser **COPY** sauf si vous avez besoin des features d'ADD.

#### WORKDIR - Définir le répertoire de travail

```dockerfile
WORKDIR /app
# Équivalent à: RUN mkdir -p /app && cd /app
# Toutes les commandes suivantes s'exécutent dans /app
```

#### ENV - Variables d'environnement

```dockerfile
ENV NODE_ENV=production
ENV PORT=3000
ENV DATABASE_URL=postgresql://localhost/db

# Utilisation dans RUN
RUN echo "Node env: $NODE_ENV"
```

#### EXPOSE - Documenter les ports

```dockerfile
EXPOSE 3000
EXPOSE 80 443
```

**Note** : EXPOSE est **documentaire** uniquement. Pour publier le port :
```bash
docker run -p 3000:3000 myapp
```

#### CMD vs ENTRYPOINT

**CMD** : Commande par défaut (peut être overridée)

```dockerfile
CMD ["node", "server.js"]

# Usage:
docker run myapp                    # Lance node server.js
docker run myapp node debug.js      # Override: lance node debug.js
```

**ENTRYPOINT** : Point d'entrée fixe (arguments s'ajoutent)

```dockerfile
ENTRYPOINT ["node"]
CMD ["server.js"]

# Usage:
docker run myapp                    # Lance node server.js
docker run myapp debug.js           # Lance node debug.js (CMD overridé)
```

**Pattern combiné** :

```dockerfile
ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["postgres"]
```

#### USER - Utilisateur d'exécution

```dockerfile
# ❌ Mauvais : Exécution en root (dangereux)
FROM node:20-alpine
COPY . /app
CMD ["node", "server.js"]

# ✅ Bon : Utilisateur non-root
FROM node:20-alpine
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs
COPY --chown=nodejs:nodejs . /app
CMD ["node", "server.js"]
```

#### LABEL - Métadonnées

```dockerfile
LABEL maintainer="fabrice@example.com"
LABEL version="1.0.0"
LABEL description="Application web Node.js"
```

#### ARG - Arguments de build

```dockerfile
ARG NODE_VERSION=20
FROM node:${NODE_VERSION}-alpine

ARG BUILD_DATE
ARG GIT_COMMIT
LABEL build.date=$BUILD_DATE
LABEL build.commit=$GIT_COMMIT
```

**Build avec arguments** :
```bash
docker build \
  --build-arg NODE_VERSION=22 \
  --build-arg BUILD_DATE=$(date -u +"%Y-%m-%dT%H:%M:%SZ") \
  --build-arg GIT_COMMIT=$(git rev-parse HEAD) \
  -t myapp:1.0 .
```

#### HEALTHCHECK - Vérification de santé

```dockerfile
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD curl -f http://localhost:3000/health || exit 1
```

**Statuts** :
- `starting` : Période de démarrage
- `healthy` : Healthcheck réussit
- `unhealthy` : Échec après N retries

#### VOLUME - Points de montage

```dockerfile
VOLUME /data
VOLUME ["/var/log", "/var/cache"]
```

**Usage** :
```bash
docker run -v my-volume:/data myapp
```

### Exemples complets par langage

#### Node.js

```dockerfile
FROM node:20-alpine

# Métadonnées
LABEL maintainer="dev@example.com"
LABEL version="1.0.0"

# Utilisateur non-root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Répertoire de travail
WORKDIR /app

# Copier package.json et installer dépendances
# (layer séparé pour cache optimal)
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

# Changer ownership et copier code
COPY --chown=nodejs:nodejs . .

# Basculer vers utilisateur non-root
USER nodejs

# Port exposé
EXPOSE 3000

# Health check
HEALTHCHECK --interval=30s --timeout=3s \
  CMD node healthcheck.js

# Commande de démarrage
CMD ["node", "server.js"]
```

#### Python (Flask/FastAPI)

```dockerfile
FROM python:3.11-slim

# Variables d'environnement
ENV PYTHONUNBUFFERED=1 \
    PYTHONDONTWRITEBYTECODE=1 \
    PIP_NO_CACHE_DIR=1

# Utilisateur non-root
RUN useradd -m -u 1000 appuser

WORKDIR /app

# Installer dépendances système
RUN apt-get update && \
    apt-get install -y --no-install-recommends gcc && \
    rm -rf /var/lib/apt/lists/*

# Copier requirements et installer
COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

# Copier code
COPY --chown=appuser:appuser . .

USER appuser

EXPOSE 8000

CMD ["uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

#### Go (statique)

```dockerfile
FROM golang:1.21-alpine AS builder

WORKDIR /build

# Copier go.mod et télécharger dépendances
COPY go.mod go.sum ./
RUN go mod download

# Copier code et compiler
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build -o app .

# Image finale (scratch = vide, 0 MB !)
FROM scratch

COPY --from=builder /build/app /app
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

EXPOSE 8080

ENTRYPOINT ["/app"]
```

#### Java (Spring Boot)

```dockerfile
FROM eclipse-temurin:17-jdk-alpine AS builder

WORKDIR /build

# Copier Maven wrapper et pom.xml
COPY mvnw pom.xml ./
COPY .mvn .mvn

# Télécharger dépendances (cache layer)
RUN ./mvnw dependency:go-offline

# Copier code et build
COPY src src
RUN ./mvnw package -DskipTests

# Image runtime
FROM eclipse-temurin:17-jre-alpine

RUN addgroup -g 1001 spring && \
    adduser -u 1001 -G spring -D spring

USER spring

WORKDIR /app

COPY --from=builder /build/target/*.jar app.jar

EXPOSE 8080

ENTRYPOINT ["java", "-jar", "app.jar"]
```

---

## Multi-stage Builds

### Pourquoi multi-stage ?

**Problème** : Images de build contiennent des outils inutiles en production.

**Exemple Node.js** :

```dockerfile
# ❌ Single-stage : 1.2 GB
FROM node:20
WORKDIR /app
COPY package*.json ./
RUN npm install  # Installe devDependencies aussi
COPY . .
RUN npm run build
CMD ["node", "dist/server.js"]
```

**Solution multi-stage** :

```dockerfile
# ✅ Multi-stage : 150 MB
# Stage 1: Build
FROM node:20 AS builder
WORKDIR /app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# Stage 2: Production
FROM node:20-alpine
WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production
COPY --from=builder /app/dist ./dist
CMD ["node", "dist/server.js"]
```

**Gains** :
- 📦 Taille : 1.2 GB → 150 MB (87% de réduction)
- 🔒 Sécurité : Pas d'outils de build en prod
- ⚡ Performance : Image plus légère à pull/push

### Pattern Build + Runtime

```dockerfile
# ===== STAGE 1: Builder =====
FROM node:20 AS builder
WORKDIR /build

# Install all dependencies (including devDependencies)
COPY package*.json ./
RUN npm install

# Build application
COPY . .
RUN npm run build
RUN npm run test  # Tests durant le build

# ===== STAGE 2: Production =====
FROM node:20-alpine AS production
WORKDIR /app

# Production dependencies only
COPY package*.json ./
RUN npm ci --only=production && \
    npm cache clean --force

# Copy built artifacts from builder
COPY --from=builder /build/dist ./dist

# Non-root user
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001
USER nodejs

EXPOSE 3000
CMD ["node", "dist/server.js"]
```

### Multi-stage avec Go (image minimale)

```dockerfile
# ===== STAGE 1: Builder =====
FROM golang:1.21-alpine AS builder

RUN apk add --no-cache git ca-certificates

WORKDIR /build

# Download dependencies
COPY go.mod go.sum ./
RUN go mod download

# Build binary
COPY . .
RUN CGO_ENABLED=0 GOOS=linux go build \
    -ldflags="-w -s" \
    -o app .

# ===== STAGE 2: Minimal runtime =====
FROM scratch

# Copy SSL certificates
COPY --from=builder /etc/ssl/certs/ca-certificates.crt /etc/ssl/certs/

# Copy binary
COPY --from=builder /build/app /app

EXPOSE 8080

ENTRYPOINT ["/app"]
```

**Résultat** : Image de **5-10 MB** seulement (vs 300+ MB avec golang:1.21-alpine) !

---

## Registres d'Images

### Docker Hub

**Le registre public par défaut** :
- 🌐 URL : https://hub.docker.com
- 📦 **Millions d'images** disponibles
- ✅ Images officielles (nginx, postgres, node, etc.)

**Statistiques 2024-2025** :
- **18 millions** d'images publiques
- **100+ millions** de pulls par jour
- **14 millions** de développeurs

**Rate limits (depuis 2020)** :

| Compte | Pulls par 6h |
|--------|-------------|
| Anonymous | 100 |
| Free (authentifié) | 200 |
| Pro | Illimité |

**Commands** :

```bash
# Login
docker login

# Pull image
docker pull nginx:alpine

# Tag image
docker tag myapp:latest username/myapp:1.0

# Push image
docker push username/myapp:1.0
```

### GitHub Container Registry (GHCR)

**Registre natif GitHub** (depuis 2020) :
- 🌐 URL : `ghcr.io`
- ✅ **Gratuit et illimité** pour public repos
- ✅ Intégration GitHub Actions
- ✅ Fine-grained permissions (GitHub teams)

**Authentification** :

```bash
# Login avec Personal Access Token
echo $GITHUB_TOKEN | docker login ghcr.io -u USERNAME --password-stdin
```

**Push vers GHCR** :

```bash
# Tag avec ghcr.io
docker tag myapp:latest ghcr.io/username/myapp:1.0

# Push
docker push ghcr.io/username/myapp:1.0
```

**GitHub Actions workflow** :

```yaml
name: Build and Push to GHCR

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

### AWS ECR (Elastic Container Registry)

**Registre Docker managé AWS** :
- ✅ Haute disponibilité (SLA 99.9%)
- ✅ Chiffrement automatique
- ✅ Scanning de vulnérabilités intégré
- ✅ Intégration IAM

**Authentification** :

```bash
aws ecr get-login-password --region eu-west-1 | \
  docker login --username AWS --password-stdin 123456789012.dkr.ecr.eu-west-1.amazonaws.com
```

**Push vers ECR** :

```bash
# Tag
docker tag myapp:latest 123456789012.dkr.ecr.eu-west-1.amazonaws.com/myapp:1.0

# Push
docker push 123456789012.dkr.ecr.eu-west-1.amazonaws.com/myapp:1.0
```

### Google Artifact Registry (GAR)

**Remplaçant de GCR (Google Container Registry)** :
- ✅ Multi-format (Docker, Maven, npm, Python)
- ✅ Régions multiples (Europe, US, Asia)
- ✅ Analyse de vulnérabilités

**Authentification** :

```bash
gcloud auth configure-docker europe-west1-docker.pkg.dev
```

### Harbor (Self-hosted)

**Registre open source CNCF** :
- ✅ Self-hosted (contrôle total)
- ✅ Replication multi-registres
- ✅ Role-Based Access Control (RBAC)
- ✅ Scanning intégré (Trivy, Clair)
- ✅ Signature d'images (Notary)

**Installation Docker Compose** :

```bash
wget https://github.com/goharbor/harbor/releases/download/v2.9.0/harbor-online-installer-v2.9.0.tgz
tar xvf harbor-online-installer-v2.9.0.tgz
cd harbor
./install.sh
```

### Image Tagging Strategies

**Stratégies de tagging** :

1. **Semantic Versioning (recommandé)** :
```bash
myapp:1.0.0     # Version spécifique
myapp:1.0       # Minor version
myapp:1         # Major version
myapp:latest    # Dernière version (⚠️ éviter en prod)
```

2. **Git commit SHA** :
```bash
myapp:a3b2c1d
```

3. **Build number** :
```bash
myapp:build-142
```

4. **Environnement + version** :
```bash
myapp:staging-1.0.0
myapp:production-1.0.0
```

**Best practice** :
```bash
# Multi-tags
docker build -t myapp:1.2.3 -t myapp:1.2 -t myapp:1 -t myapp:latest .
```

### Image Scanning (Sécurité)

**Outils de scanning** :

#### Trivy (Aqua Security)

```bash
# Install
brew install trivy

# Scan image
trivy image nginx:alpine
```

**Output** :
```
nginx:alpine (alpine 3.18.4)
Total: 5 (HIGH: 2, CRITICAL: 3)

┌─────────────────────┬────────────────┬──────────┬───────────────────┬───────────────┐
│      Library        │ Vulnerability  │ Severity │ Installed Version │ Fixed Version │
├─────────────────────┼────────────────┼──────────┼───────────────────┼───────────────┤
│ openssl             │ CVE-2023-12345 │ CRITICAL │ 3.1.3-r0          │ 3.1.4-r0      │
└─────────────────────┴────────────────┴──────────┴───────────────────┴───────────────┘
```

#### Snyk

```bash
# Install
npm install -g snyk

# Authenticate
snyk auth

# Scan image
snyk container test nginx:alpine
```

#### GitHub Actions avec Trivy

```yaml
- name: Scan image with Trivy
  uses: aquasecurity/trivy-action@master
  with:
    image-ref: 'myapp:latest'
    severity: 'CRITICAL,HIGH'
    exit-code: '1'  # Fail build if vulnerabilities found
```

---

## .dockerignore

### Pourquoi utiliser .dockerignore ?

**Problème** : `COPY . .` copie **tout** le contexte de build, y compris :
- ❌ `node_modules/` (100+ MB)
- ❌ `.git/` (historique complet)
- ❌ `tests/`, `docs/`
- ❌ Fichiers temporaires

**Solution** : `.dockerignore` exclut des fichiers du contexte de build.

**Bénéfices** :
- ⚡ **Build plus rapide** (moins de fichiers à copier)
- 📦 **Image plus petite** (pas de fichiers inutiles)
- 🔒 **Sécurité** (pas de secrets accidentels)

### Syntaxe

```dockerignore
# Commentaires commencent par #

# Patterns (comme .gitignore)
node_modules
dist
*.log
.git
.env

# Négation (inclure un fichier exclu)
!important.log

# Wildcard
**/*.md
**/__pycache__
```

### Exemples par langage

#### Node.js

```.dockerignore
# Dependencies
node_modules/
npm-debug.log*
yarn-error.log*

# Build
dist/
build/

# Testing
coverage/
.nyc_output/

# Git
.git/
.gitignore

# IDE
.vscode/
.idea/

# Environment
.env
.env.local

# Documentation
*.md
!README.md

# Logs
logs/
*.log
```

#### Python

```.dockerignore
# Virtual environments
venv/
env/
.venv/

# Python cache
__pycache__/
*.pyc
*.pyo
*.pyd
.Python

# Testing
.pytest_cache/
.coverage
htmlcov/

# Git
.git/

# IDE
.vscode/
.idea/

# Environment
.env

# Documentation
docs/
*.md
```

#### Go

```.dockerignore
# Build artifacts
bin/
*.exe

# Git
.git/

# IDE
.vscode/
.idea/

# Testing
*.test

# Vendor (si utilise go modules)
vendor/

# Documentation
*.md
!README.md
```

---

## Références

### Documentation officielle

40. **Docker Documentation** - https://docs.docker.com/
41. **Dockerfile Best Practices** - https://docs.docker.com/develop/develop-images/dockerfile_best-practices/
42. **containerd** - https://containerd.io/
43. **runc** - https://github.com/opencontainers/runc

### Registres

44. **Docker Hub** - https://hub.docker.com/
45. **GitHub Container Registry** - https://docs.github.com/en/packages/working-with-a-github-packages-registry/working-with-the-container-registry
46. **AWS ECR** - https://aws.amazon.com/ecr/
47. **Google Artifact Registry** - https://cloud.google.com/artifact-registry
48. **Harbor** - https://goharbor.io/

### Sécurité

49. **Trivy** - https://trivy.dev/
50. **Snyk Container Security** - https://snyk.io/product/container-vulnerability-management/
51. **Docker Security Best Practices** - https://cheatsheetseries.owasp.org/cheatsheets/Docker_Security_Cheat_Sheet.html

### Articles

52. **"Building Minimal Docker Images"** - Dockercon 2023
53. **"Multi-stage Builds"** - Docker Blog
54. **"Container Security 2024"** - Aqua Security Report

---

**Document créé le** : Novembre 2025
**Auteur** : Fabrice Claeys
**Formation** : Cours Initiation DevOps - M2 ESTD Architecte Web
**Institution** : ForEach Academy

---

*Ce document fait partie du Module 6 du cours DevOps. Suite : Partie 3 (Docker Compose, Microservices, Production).*

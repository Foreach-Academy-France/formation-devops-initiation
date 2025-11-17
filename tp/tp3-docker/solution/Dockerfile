# ==========================================
# Stage 1: Builder - Installation dépendances
# ==========================================
FROM node:20-alpine AS builder

# Informations de build
LABEL maintainer="M2 ESTD - ForEach Academy"
LABEL description="API DevOps pour TP Docker"

WORKDIR /app

# Copier les fichiers de dépendances
COPY package*.json ./

# Installer TOUTES les dépendances (production + dev si nécessaire)
RUN npm ci --only=production

# Copier le code source
COPY . .

# ==========================================
# Stage 2: Production - Image finale optimisée
# ==========================================
FROM node:20-alpine

WORKDIR /app

# Créer un utilisateur non-root pour la sécurité
# Principe: Ne jamais exécuter des applications en tant que root
RUN addgroup -g 1001 -S nodejs && \
    adduser -S nodejs -u 1001

# Copier seulement les fichiers nécessaires depuis le builder
# --chown pour donner ownership au user nodejs
COPY --from=builder --chown=nodejs:nodejs /app/node_modules ./node_modules
COPY --from=builder --chown=nodejs:nodejs /app/server.js ./
COPY --from=builder --chown=nodejs:nodejs /app/public ./public
COPY --from=builder --chown=nodejs:nodejs /app/package.json ./

# Basculer vers l'utilisateur non-root
USER nodejs

# Exposer le port de l'application
EXPOSE 3000

# Variables d'environnement par défaut
ENV NODE_ENV=production \
    PORT=3000

# Healthcheck pour Docker et Kubernetes
# Vérifie toutes les 30s que l'endpoint /api/health répond
HEALTHCHECK --interval=30s --timeout=3s --start-period=5s --retries=3 \
  CMD node -e "require('http').get('http://localhost:3000/api/health', (r) => process.exit(r.statusCode === 200 ? 0 : 1))"

# Commande de démarrage
CMD ["node", "server.js"]

# Objectifs Pédagogiques - TP3: Docker & Conteneurisation

## 🎯 Compétence Validée

**C20 - Concevoir et déployer une infrastructure**

> *"Conteneuriser des applications et gérer des environnements multi-services avec Docker pour des déploiements reproductibles et isolés."*

---

## 📚 Savoirs

### Conteneurisation - Concepts Fondamentaux
- ✅ Comprendre la différence entre conteneurs et machines virtuelles
- ✅ Connaître les avantages de la conteneurisation (portabilité, isolation, légèreté)
- ✅ Maîtriser le concept d'image vs conteneur
- ✅ Comprendre les layers et le système de cache
- ✅ Connaître les registres d'images (Docker Hub, GHCR, ECR)

### Architecture Docker
- ✅ Comprendre l'architecture Docker (CLI → Daemon → containerd → runc)
- ✅ Connaître les namespaces et cgroups Linux
- ✅ Comprendre le modèle réseau Docker (bridge, host, overlay)
- ✅ Maîtriser les volumes pour la persistence

### Dockerfile - Syntaxe et Instructions
- ✅ Connaître les instructions de base (FROM, COPY, RUN, CMD, EXPOSE)
- ✅ Comprendre WORKDIR, ENV, USER, LABEL
- ✅ Maîtriser les multi-stage builds
- ✅ Savoir optimiser le caching des layers
- ✅ Comprendre .dockerignore

### Docker Compose
- ✅ Comprendre la philosophie Infrastructure as Code pour stacks
- ✅ Connaître la syntaxe YAML de Compose
- ✅ Maîtriser les services, networks, volumes
- ✅ Comprendre les dépendances entre services (depends_on)
- ✅ Savoir configurer les healthchecks

### Bonnes Pratiques
- ✅ Principe du moindre privilège (utilisateur non-root)
- ✅ Images minimales (alpine, distroless)
- ✅ Multi-stage builds pour optimisation
- ✅ Healthchecks pour monitoring
- ✅ Gestion des secrets (pas dans l'image!)
- ✅ Tagging sémantique (v1.0.0, latest)

---

## 🛠️ Savoir-Faire

### Création et Gestion d'Images
- ✅ Écrire un Dockerfile fonctionnel
- ✅ Builder une image Docker (`docker build`)
- ✅ Tagger une image (`docker tag`)
- ✅ Lister et inspecter les images
- ✅ Supprimer des images inutilisées
- ✅ Analyser les layers (`docker history`)

### Dockerfile Multi-Stage
- ✅ Créer un stage "builder" pour les dépendances
- ✅ Créer un stage "production" optimisé
- ✅ Copier sélectivement depuis un stage (`COPY --from=`)
- ✅ Réduire la taille de l'image finale (30-40%)
- ✅ Configurer un utilisateur non-root pour la sécurité

### Exécution de Conteneurs
- ✅ Lancer un conteneur (`docker run`)
- ✅ Mapper des ports (`-p 3000:3000`)
- ✅ Nommer un conteneur (`--name`)
- ✅ Lancer en background (`-d`)
- ✅ Passer des variables d'environnement (`-e`)
- ✅ Monter des volumes (`-v`)
- ✅ Voir les logs (`docker logs`)
- ✅ Exécuter des commandes dans un conteneur (`docker exec`)

### Docker Compose
- ✅ Écrire un docker-compose.yml multi-services
- ✅ Définir des services (app, redis, postgres, nginx)
- ✅ Configurer des réseaux pour l'isolation
- ✅ Déclarer des volumes pour la persistence
- ✅ Gérer les dépendances et healthchecks
- ✅ Démarrer la stack (`docker-compose up`)
- ✅ Voir le statut (`docker-compose ps`)
- ✅ Consulter les logs (`docker-compose logs`)
- ✅ Arrêter proprement (`docker-compose down`)

### Registres d'Images
- ✅ Se connecter à Docker Hub (`docker login`)
- ✅ Tagger pour un registre (`username/image:tag`)
- ✅ Pousser une image (`docker push`)
- ✅ Télécharger une image (`docker pull`)
- ✅ Rendre une image publique

### Débogage et Monitoring
- ✅ Inspecter un conteneur (`docker inspect`)
- ✅ Voir les ressources utilisées (`docker stats`)
- ✅ Lire les logs en temps réel (`docker logs -f`)
- ✅ Accéder au shell d'un conteneur (`docker exec -it sh`)
- ✅ Vérifier les healthchecks

---

## 💡 Savoir-Être

### Rigueur et Sécurité
- ✅ Ne jamais exécuter des conteneurs en tant que root
- ✅ Ne jamais inclure de secrets dans les images
- ✅ Minimiser la surface d'attaque (images petites)
- ✅ Scanner les vulnérabilités (Trivy, Snyk)

### Optimisation
- ✅ Penser au caching lors de l'écriture de Dockerfile
- ✅ Ordonner les instructions du moins changeant au plus changeant
- ✅ Utiliser .dockerignore pour réduire le context
- ✅ Choisir des images de base appropriées (alpine, slim)

### Reproductibilité
- ✅ Toujours spécifier des versions précises (node:20-alpine, pas node:latest)
- ✅ Documenter les variables d'environnement (.env.example)
- ✅ Tester les images sur différents OS
- ✅ Versionner Dockerfile et docker-compose.yml dans Git

### Collaboration
- ✅ Écrire des Dockerfile lisibles et commentés
- ✅ Documenter les ports exposés et volumes
- ✅ Faciliter le onboarding ("git clone && docker-compose up")

---

## 📊 Critères d'Évaluation

### Dockerfile (40 points)
- [ ] Dockerfile syntaxiquement correct (10 pts)
- [ ] Multi-stage build implémenté (10 pts)
- [ ] Utilisateur non-root configuré (5 pts)
- [ ] Healthcheck ajouté (5 pts)
- [ ] Image finale < 200MB (10 pts)

### Docker Compose (40 points)
- [ ] docker-compose.yml syntaxiquement correct (10 pts)
- [ ] 4 services configurés (app, redis, postgres, nginx) (15 pts)
- [ ] Réseaux et volumes déclarés (5 pts)
- [ ] Healthchecks et depends_on configurés (5 pts)
- [ ] Stack complète démarre sans erreur (5 pts)

### Fonctionnement (15 points)
- [ ] Application accessible sur port 80 (via nginx) (5 pts)
- [ ] Healthcheck fonctionne (docker inspect) (5 pts)
- [ ] Données persistent après restart (volumes) (5 pts)

### Bonus (5 points)
- [ ] Image poussée sur Docker Hub/GHCR (5 pts)

### Total: 100 points
Seuil de validation: 70/100

---

## 🎓 Compétences Transversales

### Infrastructure as Code
- Dockerfile et docker-compose.yml sont du code
- Versionnés dans Git avec le code applicatif
- Reproductibles sur n'importe quel environnement

### DevOps Culture
- "It works on my machine" → Résolu par Docker
- Environnements identiques (dev/staging/prod)
- Onboarding instantané pour nouveaux développeurs

### Architecture Moderne
- Microservices isolés et scalables
- Service discovery automatique (nom du service)
- Résilience via healthchecks et restarts

### Cloud-Native
- Conteneurs = base de Kubernetes
- Images = unités de déploiement
- Compatibilité multi-cloud

---

## 🔗 Liens avec Autres Modules

### Module 3: Git & Versioning
- Dockerfile et docker-compose.yml dans Git
- Tags Git → Tags d'images Docker
- Branches pour environnements (dev/staging/prod)

### Module 5: CI/CD avec GitHub Actions
- CI build des images Docker
- Tests dans conteneurs
- Push vers registres automatique
- Déploiement de conteneurs

### Module 7: Kubernetes
- Docker = prérequis pour Kubernetes
- Images Docker déployées dans pods K8s
- docker-compose → Kubernetes manifests
- Healthchecks utilisés par K8s

---

## 📖 Pour Aller Plus Loin

### Optimisations Avancées

**Distroless Images** (Google):
```dockerfile
FROM gcr.io/distroless/nodejs20-debian11
# Image sans shell, package manager → Sécurité maximale
```

**BuildKit** (Builds parallèles):
```bash
DOCKER_BUILDKIT=1 docker build -t app .
```

**Docker Scan** (Sécurité):
```bash
docker scan mon-app:v2
```

### Docker en Production

- **Orchestration**: Kubernetes, Docker Swarm
- **Monitoring**: Prometheus + cAdvisor
- **Logging**: ELK Stack, Loki
- **Registry privé**: Harbor, Nexus
- **Security scanning**: Trivy, Snyk

### Ressources Complémentaires

- [Docker Best Practices](https://docs.docker.com/develop/dev-best-practices/)
- [Dockerfile Reference](https://docs.docker.com/engine/reference/builder/)
- [Compose File Reference](https://docs.docker.com/compose/compose-file/)
- [Docker Security](https://docs.docker.com/engine/security/)
- [Awesome Docker](https://github.com/veggiemonk/awesome-docker)

---

## 💡 Métriques de Succès

### Avant Docker
- ⏱️ Onboarding nouveau dev: **2-3 jours**
- 🐛 "Works on my machine": **Fréquent**
- 🔧 Setup environnement: **Manuel, erreur-prone**
- 📦 Déploiement: **Complexe, spécifique à l'OS**

### Après Docker
- ⏱️ Onboarding: **5 minutes** (`git clone && docker-compose up`)
- 🐛 "Works on my machine": **Résolu** (environnements identiques)
- 🔧 Setup: **Automatisé** (Dockerfile)
- 📦 Déploiement: **Uniforme** (image Docker partout)

---

**Ce TP est la fondation de l'infrastructure cloud-native moderne. Docker est PARTOUT en 2025!**

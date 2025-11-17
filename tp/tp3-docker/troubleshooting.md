# Troubleshooting - TP3: Docker

Guide de dépannage pour résoudre les erreurs courantes avec Docker et Docker Compose.

---

## 🔴 Erreurs de Prérequis

### Erreur: `docker: command not found`

**Cause**: Docker n'est pas installé ou pas dans le PATH.

**Solution**:
```bash
# Vérifier l'installation
which docker

# Si pas installé, télécharger Docker Desktop
# https://www.docker.com/products/docker-desktop

# Sur Linux, vérifier le service
sudo systemctl status docker
sudo systemctl start docker
```

---

### Erreur: `Cannot connect to the Docker daemon`

**Cause**: Docker Desktop n'est pas démarré.

**Symptôme**:
```
Cannot connect to the Docker daemon at unix:///var/run/docker.sock.
Is the docker daemon running?
```

**Solution**:
- **Windows/Mac**: Démarrer Docker Desktop (icône dans la barre système)
- **Linux**:
  ```bash
  sudo systemctl start docker
  sudo systemctl enable docker  # Démarrage automatique
  ```

---

### Erreur: `permission denied` sur Linux

**Cause**: Votre utilisateur n'est pas dans le groupe docker.

**Solution**:
```bash
# Ajouter votre utilisateur au groupe docker
sudo usermod -aG docker $USER

# Se déconnecter et reconnecter (ou redémarrer)
# Ou utiliser:
newgrp docker

# Vérifier
groups
```

---

## 🟠 Erreurs de Build Dockerfile

### Erreur: `failed to solve with frontend dockerfile.v0`

**Cause**: Erreur de syntaxe dans le Dockerfile.

**Solution**:
```bash
# Vérifier la syntaxe
cat Dockerfile

# Problèmes fréquents:
# - Majuscules obligatoires: FROM (pas from)
# - Pas de tabs, seulement des espaces
# - Instructions sur une ligne ou avec \
```

---

### Erreur: `COPY failed: stat ... no such file or directory`

**Cause**: Le fichier à copier n'existe pas dans le build context.

**Solution**:
```bash
# Vérifier où vous êtes
pwd

# Vérifier le context (dossier courant lors du build)
ls -la

# Le fichier doit être DANS le context
# Exemple: si vous êtes dans /app
# COPY package.json ./  → /app/package.json doit exister
```

---

### Erreur: `npm ERR! code ENOENT` pendant le build

**Cause**: package.json ou package-lock.json manquant.

**Solution**:
```bash
# Vérifier que package.json existe
ls -la app/

# Si package-lock.json manque, le générer
cd app
npm install
cd ..

# Rebuild
docker build -t mon-app:v1 ./app
```

---

### Erreur: Build très lent

**Cause**: Context trop large (envoie node_modules, .git, etc. à Docker).

**Solution**: Créer `.dockerignore`:
```
node_modules
.git
npm-debug.log
.env
*.md
.vscode
.idea
dist
build
coverage
```

---

## 🟡 Erreurs d'Exécution de Conteneur

### Erreur: `port is already allocated`

**Message**:
```
Error response from daemon: driver failed programming external connectivity:
Bind for 0.0.0.0:3000 failed: port is already allocated
```

**Cause**: Le port 3000 est déjà utilisé sur votre machine.

**Solution**:

**Option 1**: Utiliser un autre port:
```bash
docker run -p 3001:3000 mon-app:v1
# Puis accéder à http://localhost:3001
```

**Option 2**: Trouver et arrêter le processus qui utilise le port:
```bash
# Sur Linux/Mac
lsof -i :3000
kill -9 <PID>

# Sur Windows
netstat -ano | findstr :3000
taskkill /PID <PID> /F
```

---

### Erreur: Conteneur démarre puis s'arrête immédiatement

**Solution**:
```bash
# Voir les logs pour identifier le problème
docker logs <container_id>

# Ou voir les derniers conteneurs (même arrêtés)
docker ps -a

# Causes fréquentes:
# - Erreur dans le code (crash au démarrage)
# - CMD incorrect dans Dockerfile
# - Port déjà utilisé
# - Variable d'environnement manquante
```

---

### Erreur: `Cannot kill container: permission denied`

**Solution**:
```bash
# Utiliser sudo sur Linux
sudo docker stop <container_id>

# Ou forcer l'arrêt
docker kill <container_id>
```

---

## 🔵 Erreurs Docker Compose

### Erreur: `ERROR: yaml.scanner.ScannerError`

**Cause**: Erreur de syntaxe YAML (souvent indentation).

**Solution**:
- YAML utilise **2 espaces** pour l'indentation (PAS de tabs!)
- Vérifier avec un validateur: http://www.yamllint.com/

**Structure correcte**:
```yaml
version: '3.8'      # Pas d'indentation

services:           # Pas d'indentation
  app:              # 2 espaces
    build: ./app    # 4 espaces
    ports:          # 4 espaces
      - "3000:3000" # 6 espaces (liste)
```

---

### Erreur: `ERROR: Service 'app' failed to build`

**Cause**: Le Dockerfile dans le service a une erreur.

**Solution**:
```bash
# Builder l'image manuellement pour voir l'erreur
cd app
docker build -t app-test .

# Corriger l'erreur dans le Dockerfile
# Puis re-essayer docker-compose
cd ..
docker-compose up
```

---

### Erreur: `ERROR: for postgres  Cannot create container`

**Cause**: Un conteneur avec le même nom existe déjà.

**Solution**:
```bash
# Voir les conteneurs existants
docker ps -a | grep postgres

# Supprimer l'ancien conteneur
docker rm devops-postgres

# Ou forcer la suppression avec docker-compose
docker-compose down
docker-compose up
```

---

### Erreur: `service "postgres" didn't complete successfully: unhealthy`

**Cause**: Le healthcheck de Postgres échoue (trop lent à démarrer ou mal configuré).

**Solution**:

**Option 1**: Augmenter le start_period:
```yaml
postgres:
  healthcheck:
    start_period: 30s  # Au lieu de 10s
```

**Option 2**: Vérifier les logs:
```bash
docker-compose logs postgres
```

**Option 3**: Retirer temporairement le healthcheck pour tester.

---

## 🟢 Erreurs de Réseau et Connectivité

### Erreur: `Cannot reach service from another service`

**Exemple**: App ne peut pas se connecter à Redis.

**Causes possibles**:
1. Services pas dans le même réseau
2. Nom de host incorrect
3. Port incorrect

**Solution**:
```yaml
# Vérifier que les services sont dans le même réseau
services:
  app:
    networks:
      - app-network
  redis:
    networks:
      - app-network

# Dans le code de l'app, utiliser le nom du service comme host
# ✅ redis://redis:6379  (nom du service)
# ❌ redis://localhost:6379
```

**Débugger**:
```bash
# Accéder au shell de l'app
docker exec -it devops-app sh

# Tester la connexion
ping redis
nslookup redis
```

---

### Erreur: `Connection refused` entre services

**Cause**: Le service destination n'est pas encore prêt.

**Solution**: Utiliser `depends_on` avec healthcheck:
```yaml
app:
  depends_on:
    postgres:
      condition: service_healthy
  # Attend que postgres soit healthy avant de démarrer
```

---

## 🟣 Erreurs de Volumes

### Erreur: Données perdues après `docker-compose down`

**Cause**: Vous avez utilisé `docker-compose down -v` qui supprime les volumes.

**Solution**:
```bash
# Sans -v, les volumes persistent
docker-compose down

# Vérifier que les volumes existent
docker volume ls

# Redémarrer
docker-compose up -d
```

---

### Erreur: `no space left on device`

**Cause**: Docker utilise trop d'espace disque (images, conteneurs, volumes).

**Solution**:
```bash
# Voir l'utilisation
docker system df

# Nettoyer les conteneurs arrêtés
docker container prune

# Nettoyer les images inutilisées
docker image prune

# Nettoyer les volumes inutilisés
docker volume prune

# Tout nettoyer (ATTENTION: confirmer ce que vous faites)
docker system prune -a
```

---

## 🔧 Commandes de Dépannage

### Inspecter un Conteneur

```bash
# Voir tous les détails d'un conteneur
docker inspect devops-app

# Voir seulement l'IP
docker inspect devops-app | grep IPAddress

# Voir le healthcheck
docker inspect devops-app | grep -A 10 Health

# Voir les variables d'environnement
docker inspect devops-app | grep -A 20 Env
```

---

### Voir les Ressources Utilisées

```bash
# Voir CPU/RAM en temps réel
docker stats

# Voir pour un conteneur spécifique
docker stats devops-app

# Voir l'espace disque
docker system df
docker system df -v  # Détails
```

---

### Débugger un Conteneur qui Crash

```bash
# Voir les logs (même si conteneur arrêté)
docker logs <container_id>

# Voir les 50 dernières lignes
docker logs --tail 50 <container_id>

# Suivre les logs en temps réel
docker logs -f <container_id>

# Lancer avec mode interactif pour débugger
docker run -it mon-app:v1 sh
# Au lieu de CMD ["node", "server.js"], vous avez un shell
```

---

## 🆘 Situations Courantes

### Docker Compose ne démarre pas tous les services

**Checklist**:
```bash
# Voir le statut détaillé
docker-compose ps

# Voir les logs de TOUS les services
docker-compose logs

# Voir les logs d'un service spécifique
docker-compose logs postgres

# Redémarrer un service problématique
docker-compose restart postgres
```

---

### Image Docker trop grosse (>500MB)

**Causes**:
- Base image lourde (node:20 au lieu de node:20-alpine)
- Pas de multi-stage build
- node_modules inclus depuis le host
- Fichiers inutiles copiés (.git, tests, etc.)

**Solution**:
1. Utiliser alpine: `FROM node:20-alpine`
2. Implémenter multi-stage build
3. Créer .dockerignore complet
4. Copier seulement le nécessaire

---

### Healthcheck toujours "unhealthy"

**Solution**:
```bash
# Vérifier le healthcheck manuellement
docker exec -it devops-app sh
curl http://localhost:3000/api/health
# Doit retourner 200 OK

# Vérifier les logs du healthcheck
docker inspect devops-app | grep -A 20 Health

# Augmenter le start-period si l'app est lente à démarrer
HEALTHCHECK --start-period=30s ...
```

---

## 📚 Aide-Mémoire Docker

### Images

```bash
docker images                   # Lister
docker build -t name:tag .     # Builder
docker tag old new             # Renommer
docker rmi name:tag            # Supprimer
docker pull name:tag           # Télécharger
docker push name:tag           # Pousser
docker history name:tag        # Voir layers
```

### Conteneurs

```bash
docker ps                      # Running
docker ps -a                   # Tous
docker run -d -p 80:80 image  # Lancer (detached)
docker stop <id>              # Arrêter
docker start <id>             # Redémarrer
docker restart <id>           # Redémarrer
docker rm <id>                # Supprimer
docker logs <id>              # Logs
docker logs -f <id>           # Suivre logs
docker exec -it <id> sh       # Shell interactif
docker inspect <id>           # Détails complets
docker stats                  # Ressources
```

### Docker Compose

```bash
docker-compose up             # Démarrer (foreground)
docker-compose up -d          # Démarrer (background)
docker-compose ps             # Statut
docker-compose logs           # Tous les logs
docker-compose logs -f app    # Logs d'un service
docker-compose stop           # Arrêter
docker-compose start          # Redémarrer
docker-compose restart app    # Redémarrer un service
docker-compose down           # Arrêter et supprimer
docker-compose down -v        # + supprimer volumes
docker-compose config         # Valider YAML
docker-compose pull           # Mettre à jour images
docker-compose build          # Rebuilder images
```

### Nettoyage

```bash
docker container prune        # Conteneurs arrêtés
docker image prune           # Images dangling
docker volume prune          # Volumes inutilisés
docker network prune         # Réseaux inutilisés
docker system prune          # Tout (sans volumes)
docker system prune -a --volumes  # TOUT (DANGER!)
```

---

## 🔗 Ressources de Dépannage

- [Docker Troubleshooting](https://docs.docker.com/config/daemon/troubleshoot/)
- [Docker Compose Troubleshooting](https://docs.docker.com/compose/faq/)
- [Docker Forums](https://forums.docker.com/)
- [Stack Overflow - Docker](https://stackoverflow.com/questions/tagged/docker)
- [Docker Community Slack](https://dockr.ly/slack)

---

## 💡 Conseils Généraux

1. **Lire les logs**: `docker logs` est votre meilleur ami
2. **Build sans cache**: Si problème de cache, utiliser `--no-cache`:
   ```bash
   docker build --no-cache -t mon-app:v1 .
   ```
3. **Vérifier le .dockerignore**: Souvent cause de fichiers manquants
4. **Tester étape par étape**: Builder, run, compose séparément
5. **Docker stats**: Surveiller CPU/RAM pour identifier goulots
6. **Versions précises**: Toujours spécifier versions (`node:20-alpine`, pas `node:latest`)
7. **Nettoyer régulièrement**: Docker accumule beaucoup de données

---

## 🚨 Checklist si Rien ne Fonctionne

1. [ ] Docker Desktop est démarré (icône verte)
2. [ ] Vous êtes dans le bon dossier (`pwd`)
3. [ ] Dockerfile existe et est correct (pas de typos)
4. [ ] .dockerignore n'exclut pas des fichiers nécessaires
5. [ ] package.json existe dans le context
6. [ ] Syntaxe YAML valide (pour docker-compose)
7. [ ] Ports ne sont pas déjà utilisés
8. [ ] Assez d'espace disque (`df -h` ou `docker system df`)

Si tout est coché et ça ne marche toujours pas → **Appeler le formateur!**

---

## 🎯 Erreurs Spécifiques par Étape

### Étape 1 - Dockerfile Basique

| Erreur | Solution Rapide |
|--------|----------------|
| `npm ERR!` | Vérifier package.json existe |
| `COPY failed` | Vérifier chemin relatif au context |
| Build lent | Créer .dockerignore |
| Image trop grosse | Utiliser alpine |

### Étape 2 - Multi-Stage

| Erreur | Solution Rapide |
|--------|----------------|
| `COPY --from=builder failed` | Vérifier nom du stage |
| User nodejs failed | Alpine utilise `adduser -S` |
| Permission denied | COPY avec --chown |
| Healthcheck failed | Tester l'endpoint manuellement |

### Étape 3 - Docker Compose

| Erreur | Solution Rapide |
|--------|----------------|
| YAML error | Vérifier indentation (2 espaces) |
| Cannot find image | Vérifier le chemin `build:` |
| Service unhealthy | Augmenter start_period |
| Connection refused | Vérifier réseau et depends_on |
| Port allocated | Changer le port host |

---

## 🧰 Outils de Diagnostic

### dive - Analyser les Layers

```bash
# Installer: https://github.com/wagoodman/dive
brew install dive  # Mac
# ou télécharger le binaire

# Analyser une image
dive mon-app:v2
```

Montre:
- Taille de chaque layer
- Fichiers ajoutés/supprimés/modifiés
- Espace gaspillé

### ctop - Monitoring Conteneurs

```bash
# Installer: https://github.com/bcicen/ctop
brew install ctop

# Lancer
ctop
```

Interface TUI pour voir CPU/RAM/Réseau de tous les conteneurs.

### docker-compose validate

```bash
# Valider la syntaxe YAML
docker-compose config

# Affiche la configuration finale après interpolation
```

---

## 📞 Obtenir de l'Aide

### Dans les Logs

Les logs Docker sont très verbeux et donnent souvent la solution:
```bash
docker-compose logs
```

Chercher:
- `Error`, `FATAL`, `Exception`
- Numéros de ligne de code
- Messages de npm/Node.js

### Documentation Interactive

```bash
# Aide sur une commande
docker build --help
docker-compose up --help
```

### Communauté

- **Docker Forums**: Poser vos questions
- **Stack Overflow**: Chercher des erreurs similaires
- **ChatGPT/Claude**: Coller le message d'erreur complet

---

**En cas de blocage, gardez votre calme et débugez méthodiquement: logs → inspect → test manuel → correction.**

# 📊 Grille d'Évaluation des TP

**Compétences évaluées**:
- **C19**: Utiliser un système de gestion de versions de code source
- **C20**: Mettre en œuvre et exploiter un environnement de développement et d'intégration continue

**Note globale**: 100 points
- TP1 (Git/GitFlow): 30 points
- TP2 (GitHub Actions CI/CD): 40 points
- TP3 (Docker & Conteneurisation): 30 points

**Seuil de réussite**: 60/100 points (60%)

---

## TP1: Git & GitFlow (30 points)

**Compétence**: C19 - Utiliser un système de gestion de versions de code source

### Critères d'évaluation

| Critère | Points | Détails |
|---------|--------|---------|
| **Configuration Git** | 5 pts | User name/email configurés correctement |
| **Initialisation du repo** | 3 pts | `git init` exécuté, repo créé |
| **Branche develop** | 4 pts | Branche `develop` créée et checkoutée |
| **Feature branch** | 6 pts | Branche `feature/login` créée depuis develop, commit avec message conventionnel |
| **Merge vers develop** | 4 pts | Feature mergée dans develop sans conflit |
| **Release branch** | 4 pts | Branche `release/1.0.0` créée, version bump effectué |
| **Tag Git** | 2 pts | Tag `v1.0.0` créé sur main |
| **Hotfix** | 2 pts | Branche `hotfix/1.0.1` créée et mergée |

**Bonus (optionnel)**:
- Conventional Commits respectés partout: +2 pts
- GitFlow complet sans aide: +2 pts

**Note sur 30**: _____ / 30

---

## TP2: GitHub Actions CI/CD (40 points)

**Compétence**: C20 - Mettre en œuvre un environnement d'intégration continue

### Critères d'évaluation

| Critère | Points | Détails |
|---------|--------|---------|
| **Repo GitHub créé** | 2 pts | Repo créé et poussé sur GitHub |
| **Workflow CI basique** | 8 pts | `.github/workflows/ci.yml` fonctionnel (checkout, install, test) |
| **Tests passent** | 6 pts | Tous les tests Vitest passent dans la CI |
| **Cache dépendances** | 6 pts | `actions/cache` configuré correctement |
| **Upload artifacts** | 5 pts | Coverage uploadé comme artifact |
| **Build matrix** | 8 pts | Tests sur Node 18, 20, 22 en parallèle |
| **Badge status** | 2 pts | Badge CI ajouté au README |
| **Workflow CD** | 3 pts | Workflow de déploiement séparé (bonus) |

**Vérifications**:
- [ ] Workflow déclenché sur `push` et `pull_request`
- [ ] Jobs exécutés en parallèle (lint, test, build)
- [ ] Artifacts accessibles dans l'interface GitHub
- [ ] Matrix build avec 3 versions Node.js

**Note sur 40**: _____ / 40

---

## TP3: Docker & Conteneurisation (30 points)

**Compétence**: C20 - Mettre en œuvre un environnement de développement moderne

### Critères d'évaluation

| Critère | Points | Détails |
|---------|--------|---------|
| **Dockerfile multi-stage** | 10 pts | Stage builder + stage production séparés |
| **Image optimisée** | 5 pts | Image finale < 200 MB (Alpine + node_modules prod only) |
| **Build réussi** | 3 pts | `docker build` sans erreur |
| **Conteneur démarré** | 3 pts | `docker run` démarre l'app correctement |
| **docker-compose.yml** | 6 pts | 4 services (app, postgres, redis, nginx) définis |
| **Healthchecks** | 2 pts | Healthchecks configurés pour les services critiques |
| **Stack complète** | 1 pt | `docker-compose up` démarre toute la stack |

**Vérifications**:
- [ ] `curl localhost/health` répond 200 OK
- [ ] `docker ps` montre 4 conteneurs actifs
- [ ] `docker logs demo-api` affiche "Server running"
- [ ] `docker-compose down -v` nettoie correctement

**Note sur 30**: _____ / 30

---

## Synthèse Globale

| TP | Note | Poids | Points pondérés |
|----|------|-------|-----------------|
| TP1 (Git/GitFlow) | ___/30 | 30% | ___/30 |
| TP2 (GitHub Actions) | ___/40 | 40% | ___/40 |
| TP3 (Docker) | ___/30 | 30% | ___/30 |
| **TOTAL** | | | **___/100** |

### Appréciation

| Note | Appréciation | Compétences |
|------|-------------|-------------|
| 90-100 | Excellent ✅ | C19 & C20 **Maîtrisées** |
| 80-89 | Bien ✅ | C19 & C20 **Acquises** |
| 60-79 | Passable ⚠️ | C19 & C20 **En cours d'acquisition** |
| < 60 | Insuffisant ❌ | C19 & C20 **Non acquises** |

---

## Observations & Feedback

### Points forts
_(À remplir par le formateur)_

---

### Points à améliorer
_(À remplir par le formateur)_

---

### Conseils pour la suite
_(À remplir par le formateur)_

---

## Validation des compétences

**C19 - Utiliser un système de gestion de versions de code source**:
- [ ] ✅ **Acquise** (note TP1 ≥ 18/30)
- [ ] ⚠️ **En cours** (note TP1 entre 12-17/30)
- [ ] ❌ **Non acquise** (note TP1 < 12/30)

**C20 - Mettre en œuvre un environnement de développement/CI**:
- [ ] ✅ **Acquise** (note TP2+TP3 ≥ 42/70)
- [ ] ⚠️ **En cours** (note TP2+TP3 entre 28-41/70)
- [ ] ❌ **Non acquise** (note TP2+TP3 < 28/70)

---

**Date d'évaluation**: _______________

**Formateur**: _______________

**Signature**: _______________

---

**Grille prête ! ✅**

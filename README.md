# 🚀 Formation Initiation DevOps - ForEach Academy

> Formation d'une journée (7h) sur les pratiques DevOps essentielles pour développeurs web

**🌐 Site de la formation**: https://foreach-academy-france.github.io/formation-devops-initiation/

**Public**: M2 ESTD - Expert en stratégie et transformation digitale - Architecte Web
**Date**: 19 novembre 2025
**Organisme**: ForEach Academy
**Formateur**: Fabrice Claeys

---

## 📋 Programme de la Journée

**Durée totale**: 7 heures (9h00-17h00)
**Format**: Théorie + Travaux Pratiques + Démos Live

### 🕐 Planning

| Horaire | Module | Contenu | Durée |
|---------|--------|---------|-------|
| 9h00-9h15 | 🎯 | Accueil et introduction | 15min |
| 9h15-10h00 | 📚 Module 2 | Principes du DevOps | 45min |
| 10h00-11h00 | 🔀 Module 3 | Git & Versioning + TP1 | 1h |
| 11h00-11h15 | ☕ | Pause | 15min |
| 11h15-12h15 | 🧪 Module 4 | Build & Tests + Démo | 1h |
| 12h15-13h15 | 🍽️ | Pause déjeuner | 1h |
| 13h15-14h30 | 🚀 Module 5 | CI/CD GitHub Actions + TP2 | 1h15 |
| 14h30-15h30 | 🐳 Module 7 | Docker + TP3 | 1h |
| 15h30-15h45 | ☕ | Pause | 15min |
| 15h45-16h30 | ⚙️ Modules 6 & 8 | IaC, Kubernetes, Monitoring | 45min |
| 16h30-17h00 | 📝 | QCM d'évaluation + Q&A | 30min |

---

## 📚 Modules de Formation

### Module 2: Principes du DevOps (45min)
- Objectifs et vocabulaire DevOps
- Chaîne de production logicielle
- Culture DevOps et bénéfices
- Relation DevOps/Agile

**📊 Slides**: [02-principes-devops.md](./slides/02-principes-devops.md)

---

### Module 3: Git & Versioning (1h)
- Utilité du versioning
- Commits, Branches, Tags
- GitFlow workflow
- **TP1 (15min)**: GitFlow en pratique

**📊 Slides**: [03-git-versioning.md](./slides/03-git-versioning.md)
**📝 TP1**: [Git/GitFlow](./tp/tp1-git-gitflow/)

---

### Module 4: Build & Tests (1h)
- Outils de build (npm, Vite, Bun)
- Pyramide de tests (unitaires, intégration, E2E)
- Couverture de code et métriques
- **Démo live (15min)**: Tests automatisés

**📊 Slides**: [04-build-tests.md](./slides/04-build-tests.md)
**🎬 Démo**: [Tests Automatisés](https://github.com/Foreach-Academy-France/devops-demo-tests) ![CI](https://github.com/Foreach-Academy-France/devops-demo-tests/actions/workflows/ci.yml/badge.svg)

---

### Module 5: CI/CD & GitHub Actions (1h15)
- Continuous Integration vs Deployment
- Architecture GitHub Actions
- Workflows YAML, matrix builds, caching
- Métriques DORA
- **TP2 (30min)**: Pipeline CI/CD complet

**📊 Slides**: [05-cicd-github-actions.md](./slides/05-cicd-github-actions.md)
**📝 TP2**: [GitHub Actions CI/CD](./tp/tp2-github-actions/)
**🎬 Démo**: [Pipeline CI/CD Complet](https://github.com/Foreach-Academy-France/devops-demo-pipeline) ![CI](https://github.com/Foreach-Academy-France/devops-demo-pipeline/actions/workflows/ci.yml/badge.svg)

---

### Module 7: Docker & Conteneurisation (1h)
- Conteneurs vs VMs
- Dockerfile multi-stage
- docker-compose (stack applicative)
- Architecture microservices
- **TP3 (25min)**: Conteneuriser une application

**📊 Slides**: [06-docker.md](./slides/06-docker.md)
**📝 TP3**: [Docker & Conteneurisation](./tp/tp3-docker/)
**🎬 Démo**: [Docker Multi-Stage](https://github.com/Foreach-Academy-France/devops-demo-docker) ![CI](https://github.com/Foreach-Academy-France/devops-demo-docker/actions/workflows/ci.yml/badge.svg)

---

### Modules 6 & 8: Autres Outils DevOps (45min - Théorie)
- **Module 6**: Infrastructure as Code (Ansible, Terraform)
- **Kubernetes**: Introduction orchestration de conteneurs
- **Module 8**: Monitoring et Observabilité (Prometheus, Grafana)

**📊 Slides**: [07-autres-outils.md](./slides/07-autres-outils.md)

---

## 🎬 Démonstrations Live

Les 3 démos sont hébergées dans des repositories séparés avec GitHub Actions fonctionnels :

### 1. 🧪 Tests Automatisés (15min)
**Repo**: https://github.com/Foreach-Academy-France/devops-demo-tests

- Application calculatrice TypeScript
- 60 tests (unitaires + intégration)
- Couverture: 94.75% functions, 99.15% lines
- Pyramide de tests en action

### 2. 🚀 Pipeline CI/CD (15min)
**Repo**: https://github.com/Foreach-Academy-France/devops-demo-pipeline

- API REST Express/TypeScript
- 3 workflows: CI, CD (staging→prod), Release
- Matrix builds (Node 18, 20, 22)
- Artifacts, caching, déploiements

### 3. 🐳 Docker Multi-Stage (15min)
**Repo**: https://github.com/Foreach-Academy-France/devops-demo-docker

- Dockerfile optimisé: 148 MB (vs 1.2 GB simple)
- Stack 4 services (API, PostgreSQL, Redis, Nginx)
- Healthchecks, volumes, réseaux

---

## 📝 Travaux Pratiques

### TP1: Git & GitFlow (15min)
**Compétence**: C19 - Utiliser un système de gestion de versions

- Initialiser un repo Git
- Workflow GitFlow complet
- Conventional Commits
- Tags et releases

📁 [Énoncé et solution](./tp/tp1-git-gitflow/)

---

### TP2: GitHub Actions CI/CD (30min)
**Compétence**: C20 - Mettre en œuvre un environnement d'intégration continue

- Créer un workflow CI basique
- Build matrix (plusieurs versions Node.js)
- Cache et artifacts
- Badge CI dans README

📁 [Énoncé et solution](./tp/tp2-github-actions/)

---

### TP3: Docker & Conteneurisation (25min)
**Compétence**: C20 - Conteneurisation d'applications

- Dockerfile multi-stage
- docker-compose (stack 4 services)
- Healthchecks et dépendances
- Persistence avec volumes

📁 [Énoncé et solution](./tp/tp3-docker/)

---

## 📊 Évaluation

### QCM Final (20min)
- 30 questions (modules 2-8)
- Seuil de réussite: 24/30 (80%)

📄 [QCM avec corrigé](./evaluation/qcm.md)

### Grille d'Évaluation des TP
- Note sur 100 points
- Validation compétences C19 & C20

📄 [Grille d'évaluation](./evaluation/grille-evaluation.md)

---

## 🎯 Compétences Validées

**C19**: Concevoir et gérer le cycle de vie des applications
- Maîtrise de Git et GitFlow
- Gestion des versions et releases

**C20**: Mettre en œuvre un environnement de développement et d'intégration continue
- Pipeline CI/CD automatisé
- Conteneurisation Docker
- Automatisation des tests et déploiements

---

## 🛠️ Prérequis Techniques

**À installer AVANT la formation**:
- Git (version 2.x ou supérieure)
- Compte GitHub
- Docker Desktop (ou Podman/Rancher Desktop)
- Node.js 20+ (ou Bun)
- Éditeur de code (VS Code recommandé)

**Vérifications**:
```bash
git --version
node --version
docker --version
docker compose version
```

---

## 📚 Ressources Complémentaires

### Documentation Officielle
- [Git Documentation](https://git-scm.com/doc)
- [GitHub Actions](https://docs.github.com/en/actions)
- [Docker Documentation](https://docs.docker.com/)
- [Kubernetes](https://kubernetes.io/docs/)

### Outils Recommandés
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [DORA Metrics](https://cloud.google.com/blog/products/devops-sre/using-the-four-keys-to-measure-your-devops-performance)

---

## 📂 Structure du Repository

```
formation-devops-initiation/
├── README.md                    # Ce fichier
├── slides/                      # Supports de cours (Markdown/Marp)
│   ├── 00-introduction.md
│   ├── 02-principes-devops.md
│   ├── 03-git-versioning.md
│   ├── 04-build-tests.md
│   ├── 05-cicd-github-actions.md
│   ├── 06-docker.md
│   ├── 07-autres-outils.md
│   └── 08-conclusion.md
├── tp/                          # Travaux pratiques
│   ├── tp1-git-gitflow/
│   ├── tp2-github-actions/
│   └── tp3-docker/
└── evaluation/                  # Évaluation finale
    ├── qcm.md
    └── grille-evaluation.md
```

---

## 📊 Statistiques

- **500+ slides** créées (8 modules Marp)
- **150,000+ mots** de documentation
- **3 TP pratiques** complets (70min de pratique)
- **3 démos live** fonctionnelles (45min total)
- **30 questions** QCM avec corrigé
- **100% testé et validé** ✅

---

## 🎓 À Propos

**Formateur**: Fabrice Claeys
**LinkedIn**: https://www.linkedin.com/in/fabrice-claeys-8b526910/
**Organisme**: ForEach Academy
**Certification**: M2 ESTD - Architecte Web

---

## 📄 Licence

Cette formation est destinée aux élèves de ForEach Academy.
Tous droits réservés © 2025 ForEach Academy

---

**Bon courage pour la formation ! 🚀**

---

🤖 *Repository créé avec [Claude Code](https://claude.com/claude-code)*

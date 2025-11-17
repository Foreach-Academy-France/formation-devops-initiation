# Objectifs Pédagogiques - TP1: Git/GitFlow

## 🎯 Compétence Validée

**C19 - Concevoir et gérer le cycle de vie des applications**

> *"Gérer les versions du code source et coordonner le travail de l'équipe de développement via des systèmes de contrôle de version distribués."*

---

## 📚 Savoirs

### Concepts Git Fondamentaux
- ✅ Comprendre le modèle de données de Git (commits, arbres, blobs)
- ✅ Maîtriser les concepts de branches et de fusion
- ✅ Connaître les différents types de merge (fast-forward, no-ff)
- ✅ Comprendre le rôle des tags pour le versioning

### Workflow GitFlow
- ✅ Comprendre la philosophie GitFlow
- ✅ Connaître les 5 types de branches (main, develop, feature, release, hotfix)
- ✅ Savoir quand utiliser chaque type de branche
- ✅ Comprendre le flux de fusion entre les branches

### Standards et Bonnes Pratiques
- ✅ Conventional Commits (type, scope, description)
- ✅ Semantic Versioning (MAJOR.MINOR.PATCH)
- ✅ Messages de commit descriptifs et atomiques

---

## 🛠️ Savoir-Faire

### Opérations Git de Base
- ✅ Initialiser un dépôt Git local
- ✅ Créer et basculer entre des branches
- ✅ Effectuer des commits atomiques et bien documentés
- ✅ Fusionner des branches avec différentes stratégies

### Workflow GitFlow en Pratique
- ✅ Créer une branche develop depuis main
- ✅ Créer une feature branch et l'intégrer dans develop
- ✅ Préparer une release et la fusionner dans main et develop
- ✅ Créer des tags de version sur main
- ✅ Gérer un hotfix urgent sur la production

### Gestion de Version
- ✅ Appliquer semantic versioning (1.0.0 → 1.0.1)
- ✅ Créer des tags annotés avec description
- ✅ Maintenir la cohérence entre versions (package.json, tags, commits)

### Débogage et Visualisation
- ✅ Utiliser `git log --graph` pour visualiser l'historique
- ✅ Lire et interpréter un arbre Git
- ✅ Vérifier l'état du dépôt avec `git status` et `git branch`

---

## 💡 Savoir-Être

### Rigueur et Organisation
- ✅ Écrire des messages de commit clairs et descriptifs
- ✅ Respecter les conventions d'équipe (Conventional Commits)
- ✅ Organiser le travail en branches thématiques

### Travail Collaboratif
- ✅ Comprendre l'impact des fusions sur l'équipe
- ✅ Maintenir un historique Git lisible pour les collaborateurs
- ✅ Anticiper les conflits en organisant bien les branches

### Autonomie
- ✅ Savoir débugger des problèmes Git courants
- ✅ Consulter la documentation Git en cas de besoin
- ✅ Appliquer le workflow approprié selon le contexte

---

## 📊 Critères d'Évaluation

### Complétude (40 points)
- [ ] Initialisation correcte du projet (5 pts)
- [ ] Branche develop créée et utilisée (5 pts)
- [ ] Feature branch créée, développée et fusionnée (10 pts)
- [ ] Release branch avec version correcte (10 pts)
- [ ] Hotfix appliqué correctement (10 pts - bonus)

### Qualité des Commits (30 points)
- [ ] Messages suivent Conventional Commits (15 pts)
- [ ] Commits atomiques et logiques (10 pts)
- [ ] Descriptions claires et pertinentes (5 pts)

### Gestion des Versions (20 points)
- [ ] Tag v1.0.0 créé sur main après release (10 pts)
- [ ] Tag v1.0.1 créé après hotfix (5 pts)
- [ ] Versions cohérentes dans package.json (5 pts)

### Arbre Git (10 points)
- [ ] Arbre Git propre et lisible avec `git log --graph` (5 pts)
- [ ] Fusions correctes (no-ff) montrant les branches (5 pts)

### Total: 100 points
Seuil de validation: 70/100

---

## 🎓 Compétences Transversales

### Méthodologie
- Appliquer une méthodologie de gestion de version en production
- Organiser le développement en branches parallèles
- Coordonner les releases avec l'équipe

### Outils DevOps
- Maîtriser Git, outil fondamental du DevOps
- Préparer l'intégration avec CI/CD (branches = triggers)
- Comprendre le lien entre versioning et déploiement

### Documentation
- Documenter les changements via commits
- Utiliser les tags comme points de repère
- Maintenir un historique exploitable

---

## 🔗 Liens avec Autres Modules

### Module 5: CI/CD avec GitHub Actions
- Les branches GitFlow sont des **triggers** de workflows
- `main` → déploiement production
- `develop` → déploiement staging
- `feature/*` → tests automatiques

### Module 6: Docker
- Tags Git ↔ Tags d'images Docker
- Version sémantique appliquée aux conteneurs
- GitFlow structure les environnements (dev/staging/prod)

### Module 7: Infrastructure as Code
- Code infra versionné avec Git
- Tags IaC pour releases stables
- Branches pour tester changements infra

---

## 📖 Pour Aller Plus Loin

### Après ce TP
- Pratiquer GitFlow sur vos projets personnels
- Explorer GitHub Flow (workflow simplifié)
- Découvrir Trunk-Based Development
- Utiliser GitLens (extension VS Code) pour visualiser Git

### Ressources Complémentaires
- [Atlassian GitFlow Tutorial](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Git Branching Model](https://nvie.com/posts/a-successful-git-branching-model/) (article original de Vincent Driessen)
- [Oh Shit, Git!?!](https://ohshitgit.com/) (guide de dépannage humoristique)
- [GitHub Git Cheat Sheet](https://education.github.com/git-cheat-sheet-education.pdf)

---

**Ce TP est la base de tout le DevOps moderne. Maîtriser Git/GitFlow est essentiel pour la suite de votre parcours!**

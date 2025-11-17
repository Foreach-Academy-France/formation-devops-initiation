# TP GitHub Actions - Solution Complète

![CI Pipeline](https://github.com/USERNAME/tp-github-actions/workflows/CI%20Pipeline/badge.svg)
![Deploy](https://github.com/USERNAME/tp-github-actions/workflows/Deploy/badge.svg)

> **N'oubliez pas de remplacer USERNAME par votre username GitHub!**

Formation M2 ESTD - Initiation DevOps - ForEach Academy

---

## 📋 À Propos

Application de calculatrice simple avec CI/CD complet via GitHub Actions.

**Fonctionnalités**:
- ✅ Tests automatiques sur chaque push
- ✅ Matrix build (Node 18/20/22 × Ubuntu/Windows)
- ✅ Cache intelligent des dépendances
- ✅ Upload des artifacts de build
- ✅ Déploiement automatique sur tags Git

---

## 🚀 Installation

```bash
npm install
```

---

## 🧪 Tests

```bash
# Exécuter les tests une fois
npm test

# Mode watch (développement)
npm run test:watch
```

---

## 🏗️ Build

```bash
npm run build
```

Les fichiers buildés seront dans le dossier `dist/`.

---

## 📊 CI/CD Pipeline

### Workflow CI (`ci.yml`)

**Triggers**:
- Push sur branches `main` et `develop`
- Pull requests vers `main`

**Jobs** (6 en parallèle):
- ubuntu-latest × Node 18, 20, 22
- windows-latest × Node 18, 20, 22

**Steps**:
1. Checkout du code
2. Setup Node.js (version matrix)
3. Cache des node_modules
4. Installation des dépendances
5. Exécution des tests
6. Build de l'application
7. Upload des artifacts

**Optimisations**:
- ⚡ Cache: ~70% de temps économisé
- 🔄 Parallélisme: 6 environnements testés simultanément
- 📦 Artifacts: Builds disponibles pendant 7 jours

---

### Workflow Deploy (`deploy.yml`)

**Triggers**:
- Push de tags (`v*`)
- Déclenchement manuel (workflow_dispatch)

**Actions**:
1. Checkout, setup, cache
2. Tests (sécurité)
3. Build production
4. Déploiement simulé
5. Création de release GitHub

---

## 📈 Métriques

### Temps d'Exécution

**Sans cache**:
- ~45-60 secondes par job
- Total: ~45-60s (parallèle)

**Avec cache**:
- ~15-20 secondes par job
- Total: ~15-20s (parallèle)

**Gain**: 70% de temps économisé

---

## 🎯 Commandes Utiles

```bash
# Installer les dépendances
npm install

# Lancer les tests
npm test

# Builder l'application
npm run build

# Pousser et déclencher le CI
git push

# Créer un tag et déclencher le déploiement
git tag v1.0.0
git push --tags
```

---

## 🔗 Liens

- [GitHub Actions Documentation](https://docs.github.com/en/actions)
- [Actions Marketplace](https://github.com/marketplace?type=actions)
- [Vitest Documentation](https://vitest.dev/)

---

## 📝 Notes

Ce projet est une démonstration pédagogique des capacités de GitHub Actions:
- Tests multi-versions
- Tests multi-OS
- Optimisation avec cache
- Artifacts de build
- Déploiement automatique

**Formation**: M2 ESTD - Initiation DevOps
**Formateur**: Fabrice Claeys
**ForEach Academy** - 2025

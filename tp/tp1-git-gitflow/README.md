# TP1: Git/GitFlow Workflow

**Durée**: 15 minutes
**Difficulté**: ⭐⭐☆☆☆
**Compétences**: C19 - Conception et gestion du cycle de vie des applications

---

## 🎯 Objectifs

À la fin de ce TP, vous serez capable de:
- ✅ Créer et gérer des branches Git
- ✅ Appliquer le workflow GitFlow (feature, develop, main)
- ✅ Créer des tags de version (semantic versioning)
- ✅ Écrire des commits avec Conventional Commits
- ✅ Simuler un hotfix sur la production

---

## 📋 Prérequis

- Git installé (`git --version`)
- Configuration Git:
  ```bash
  git config --global user.name "Votre Nom"
  git config --global user.email "votre.email@example.com"
  ```

---

## 🚀 Étape 1: Setup du Projet (2 minutes)

### 1.1 Créer le dossier du projet

```bash
cd ~/Desktop
mkdir mon-projet-devops
cd mon-projet-devops
```

### 1.2 Initialiser Git

```bash
git init
git branch -M main
```

### 1.3 Créer le README initial

```bash
echo "# Mon Projet DevOps" > README.md
echo "" >> README.md
echo "Formation M2 ESTD - ForEach Academy" >> README.md
```

### 1.4 Premier commit

```bash
git add README.md
git commit -m "chore: initial commit"
```

### ✓ Point de Validation

```bash
git log --oneline
```

Vous devez voir: `chore: initial commit`

---

## 🌿 Étape 2: Créer la Branche Develop (3 minutes)

### 2.1 Créer et basculer sur develop

```bash
git checkout -b develop
```

### 2.2 Ajouter un fichier package.json

```bash
cat > package.json << 'EOF'
{
  "name": "mon-projet-devops",
  "version": "0.1.0",
  "description": "Application de démo pour TP DevOps",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  }
}
EOF
```

### 2.3 Créer un fichier app.js

```bash
cat > app.js << 'EOF'
console.log('Mon application DevOps');
console.log('Version: 0.1.0');
EOF
```

### 2.4 Commit sur develop

```bash
git add package.json app.js
git commit -m "feat: add initial application structure"
```

### ✓ Point de Validation

```bash
git branch
```

Vous devez voir: `* develop` et `main`

---

## 🎨 Étape 3: Feature Branch - Nouvelle Fonctionnalité (4 minutes)

### 3.1 Créer une branche feature depuis develop

```bash
git checkout -b feature/authentication
```

### 3.2 Ajouter le fichier auth.js

```bash
cat > auth.js << 'EOF'
function login(username, password) {
  console.log(`Authentification de ${username}`);
  // TODO: Implémenter la logique d'authentification
  return true;
}

function logout() {
  console.log('Déconnexion de l'utilisateur');
}

module.exports = { login, logout };
EOF
```

### 3.3 Mettre à jour app.js

```bash
cat > app.js << 'EOF'
const auth = require('./auth');

console.log('Mon application DevOps');
console.log('Version: 0.1.0');

// Test de l'authentification
auth.login('admin', 'password');
EOF
```

### 3.4 Commit avec Conventional Commit

```bash
git add auth.js app.js
git commit -m "feat(auth): add authentication module with login/logout functions"
```

### 3.5 Merger la feature dans develop

```bash
git checkout develop
git merge feature/authentication --no-ff -m "feat: merge authentication feature into develop"
```

### ✓ Point de Validation

```bash
git log --oneline --graph
```

Vous devez voir l'arbre avec la fusion de la feature.

---

## 🏷️ Étape 4: Release Branch - Version 1.0.0 (3 minutes)

### 4.1 Créer une branche release depuis develop

```bash
git checkout -b release/1.0.0
```

### 4.2 Mettre à jour la version dans package.json

```bash
cat > package.json << 'EOF'
{
  "name": "mon-projet-devops",
  "version": "1.0.0",
  "description": "Application de démo pour TP DevOps",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  }
}
EOF
```

### 4.3 Mettre à jour app.js avec la nouvelle version

```bash
sed -i 's/Version: 0.1.0/Version: 1.0.0/' app.js
# Sur Mac, utiliser: sed -i '' 's/Version: 0.1.0/Version: 1.0.0/' app.js
```

### 4.4 Commit de la release

```bash
git add package.json app.js
git commit -m "chore(release): bump version to 1.0.0"
```

### 4.5 Merger la release dans main

```bash
git checkout main
git merge release/1.0.0 --no-ff -m "chore: release version 1.0.0"
```

### 4.6 Créer le tag v1.0.0

```bash
git tag -a v1.0.0 -m "Release version 1.0.0 - Authentication feature"
```

### 4.7 Merger la release dans develop

```bash
git checkout develop
git merge release/1.0.0 --no-ff -m "chore: merge release 1.0.0 back into develop"
```

### 4.8 Supprimer la branche release

```bash
git branch -d release/1.0.0
```

### ✓ Point de Validation

```bash
git tag
git log --oneline --graph --all --decorate
```

Vous devez voir:
- Tag `v1.0.0`
- Branches `main` et `develop` au même niveau

---

## 🚨 Étape 5 (BONUS): Hotfix - Correction en Production (3 minutes)

### 5.1 Créer une branche hotfix depuis main

```bash
git checkout main
git checkout -b hotfix/1.0.1
```

### 5.2 Corriger un bug critique dans app.js

```bash
cat > app.js << 'EOF'
const auth = require('./auth');

console.log('Mon application DevOps');
console.log('Version: 1.0.1');

// Fix: Vérifier que auth existe avant utilisation
if (auth && typeof auth.login === 'function') {
  auth.login('admin', 'password');
} else {
  console.error('Module d\'authentification non disponible');
}
EOF
```

### 5.3 Mettre à jour package.json

```bash
cat > package.json << 'EOF'
{
  "name": "mon-projet-devops",
  "version": "1.0.1",
  "description": "Application de démo pour TP DevOps",
  "main": "app.js",
  "scripts": {
    "start": "node app.js"
  }
}
EOF
```

### 5.4 Commit du hotfix

```bash
git add app.js package.json
git commit -m "fix(app): add null check for auth module to prevent crash"
```

### 5.5 Merger le hotfix dans main

```bash
git checkout main
git merge hotfix/1.0.1 --no-ff -m "fix: apply hotfix 1.0.1"
```

### 5.6 Créer le tag v1.0.1

```bash
git tag -a v1.0.1 -m "Hotfix 1.0.1 - Fix auth module crash"
```

### 5.7 Merger le hotfix dans develop

```bash
git checkout develop
git merge hotfix/1.0.1 --no-ff -m "fix: merge hotfix 1.0.1 into develop"
```

### 5.8 Supprimer la branche hotfix

```bash
git branch -d hotfix/1.0.1
```

### ✓ Point de Validation Final

```bash
git log --oneline --graph --all --decorate
git tag
```

Vous devez voir:
- Tags: `v1.0.0` et `v1.0.1`
- Arbre Git avec toutes les fusions
- Branches `main` et `develop` synchronisées

---

## 📊 Vérification Complète

### Commandes de vérification

```bash
# Vérifier tous les commits
git log --oneline --graph --all --decorate

# Compter les commits
git rev-list --count HEAD

# Vérifier les tags
git tag -n

# Vérifier les branches
git branch -a

# Afficher les détails d'un tag
git show v1.0.0
```

### Résultat attendu

Vous devriez avoir:
- ✅ Au moins **8 commits** (initial + develop + feature + release + hotfix)
- ✅ **2 tags**: v1.0.0 et v1.0.1
- ✅ **2 branches**: main et develop
- ✅ **Arbre Git** montrant toutes les fusions
- ✅ Messages de commit suivant **Conventional Commits**

---

## 🎓 Concepts Clés Appris

### GitFlow Branches

| Branche | Rôle | Créée depuis | Merge dans |
|---------|------|--------------|------------|
| `main` | Production stable | - | - |
| `develop` | Développement en cours | `main` | - |
| `feature/*` | Nouvelles fonctionnalités | `develop` | `develop` |
| `release/*` | Préparation release | `develop` | `main` + `develop` |
| `hotfix/*` | Corrections urgentes | `main` | `main` + `develop` |

### Conventional Commits

Format: `<type>(<scope>): <description>`

Types courants:
- `feat`: Nouvelle fonctionnalité
- `fix`: Correction de bug
- `chore`: Tâches de maintenance
- `docs`: Documentation
- `refactor`: Refactoring
- `test`: Tests
- `style`: Formatage

### Semantic Versioning

Format: `MAJOR.MINOR.PATCH` (ex: 1.0.1)

- **MAJOR**: Changements incompatibles
- **MINOR**: Nouvelles fonctionnalités compatibles
- **PATCH**: Corrections de bugs

---

## 🔗 Ressources

- [GitFlow Workflow](https://www.atlassian.com/git/tutorials/comparing-workflows/gitflow-workflow)
- [Conventional Commits](https://www.conventionalcommits.org/)
- [Semantic Versioning](https://semver.org/)
- [Git Documentation](https://git-scm.com/doc)

---

## ✅ Checklist de Complétion

- [ ] Étape 1: Projet initialisé avec premier commit
- [ ] Étape 2: Branche develop créée avec structure app
- [ ] Étape 3: Feature authentication mergée dans develop
- [ ] Étape 4: Release 1.0.0 taguée sur main
- [ ] Étape 5 (Bonus): Hotfix 1.0.1 appliqué
- [ ] Arbre Git complet et cohérent
- [ ] Tags v1.0.0 et v1.0.1 créés
- [ ] Messages de commit suivent Conventional Commits

---

**Formateur**: Fabrice Claeys
**Formation**: M2 ESTD - Initiation DevOps
**ForEach Academy** - 2025

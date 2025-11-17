#!/bin/bash

# TP1: Git/GitFlow Workflow - Solution Complète
# Formation M2 ESTD - ForEach Academy
# Durée: 15 minutes

# ========================================
# ÉTAPE 1: Setup du Projet (2 min)
# ========================================

echo "=== ÉTAPE 1: Setup du Projet ==="

# Créer le dossier du projet
cd ~/Desktop
mkdir mon-projet-devops
cd mon-projet-devops

# Initialiser Git
git init
git branch -M main

# Créer le README initial
echo "# Mon Projet DevOps" > README.md
echo "" >> README.md
echo "Formation M2 ESTD - ForEach Academy" >> README.md

# Premier commit
git add README.md
git commit -m "chore: initial commit"

# Vérification
echo "✓ Point de validation:"
git log --oneline

# ========================================
# ÉTAPE 2: Créer la Branche Develop (3 min)
# ========================================

echo ""
echo "=== ÉTAPE 2: Créer la Branche Develop ==="

# Créer et basculer sur develop
git checkout -b develop

# Ajouter package.json
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

# Créer app.js
cat > app.js << 'EOF'
console.log('Mon application DevOps');
console.log('Version: 0.1.0');
EOF

# Commit sur develop
git add package.json app.js
git commit -m "feat: add initial application structure"

# Vérification
echo "✓ Point de validation:"
git branch

# ========================================
# ÉTAPE 3: Feature Branch (4 min)
# ========================================

echo ""
echo "=== ÉTAPE 3: Feature Branch - Authentification ==="

# Créer branche feature
git checkout -b feature/authentication

# Ajouter auth.js
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

# Mettre à jour app.js
cat > app.js << 'EOF'
const auth = require('./auth');

console.log('Mon application DevOps');
console.log('Version: 0.1.0');

// Test de l'authentification
auth.login('admin', 'password');
EOF

# Commit de la feature
git add auth.js app.js
git commit -m "feat(auth): add authentication module with login/logout functions"

# Merger la feature dans develop
git checkout develop
git merge feature/authentication --no-ff -m "feat: merge authentication feature into develop"

# Vérification
echo "✓ Point de validation:"
git log --oneline --graph

# ========================================
# ÉTAPE 4: Release Branch - v1.0.0 (3 min)
# ========================================

echo ""
echo "=== ÉTAPE 4: Release Branch - Version 1.0.0 ==="

# Créer branche release
git checkout -b release/1.0.0

# Mettre à jour version dans package.json
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

# Mettre à jour version dans app.js
# Note: Sur Mac, utiliser sed -i '' au lieu de sed -i
if [[ "$OSTYPE" == "darwin"* ]]; then
  sed -i '' 's/Version: 0.1.0/Version: 1.0.0/' app.js
else
  sed -i 's/Version: 0.1.0/Version: 1.0.0/' app.js
fi

# Commit de la release
git add package.json app.js
git commit -m "chore(release): bump version to 1.0.0"

# Merger dans main
git checkout main
git merge release/1.0.0 --no-ff -m "chore: release version 1.0.0"

# Créer le tag
git tag -a v1.0.0 -m "Release version 1.0.0 - Authentication feature"

# Merger dans develop
git checkout develop
git merge release/1.0.0 --no-ff -m "chore: merge release 1.0.0 back into develop"

# Supprimer branche release
git branch -d release/1.0.0

# Vérification
echo "✓ Point de validation:"
git tag
git log --oneline --graph --all --decorate

# ========================================
# ÉTAPE 5 (BONUS): Hotfix - v1.0.1 (3 min)
# ========================================

echo ""
echo "=== ÉTAPE 5 (BONUS): Hotfix - Version 1.0.1 ==="

# Créer branche hotfix depuis main
git checkout main
git checkout -b hotfix/1.0.1

# Corriger le bug dans app.js
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

# Mettre à jour package.json
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

# Commit du hotfix
git add app.js package.json
git commit -m "fix(app): add null check for auth module to prevent crash"

# Merger dans main
git checkout main
git merge hotfix/1.0.1 --no-ff -m "fix: apply hotfix 1.0.1"

# Créer le tag
git tag -a v1.0.1 -m "Hotfix 1.0.1 - Fix auth module crash"

# Merger dans develop
git checkout develop
git merge hotfix/1.0.1 --no-ff -m "fix: merge hotfix 1.0.1 into develop"

# Supprimer branche hotfix
git branch -d hotfix/1.0.1

# ========================================
# VÉRIFICATION FINALE
# ========================================

echo ""
echo "=== ✅ VÉRIFICATION FINALE ==="
echo ""

echo "📊 Arbre Git complet:"
git log --oneline --graph --all --decorate

echo ""
echo "🏷️  Tags créés:"
git tag -n

echo ""
echo "🌿 Branches actuelles:"
git branch -a

echo ""
echo "📈 Nombre de commits:"
git rev-list --count HEAD

echo ""
echo "✅ TP1 Terminé!"
echo ""
echo "Résumé:"
echo "  - Commits: $(git rev-list --count HEAD)"
echo "  - Tags: $(git tag | wc -l)"
echo "  - Branches: main, develop"
echo "  - GitFlow: feature → release → hotfix ✓"
echo ""
